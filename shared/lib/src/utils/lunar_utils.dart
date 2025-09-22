import 'dart:math';

class LunarUtils {
  const LunarUtils._();

  static LunarDate solarToLunar(DateTime date, {double timeZone = 7.0}) {
    final dd = date.day;
    final mm = date.month;
    final yy = date.year;

    final dayNumber = jdFromDate(dd, mm, yy);
    final k = _toInt((dayNumber - 2415021.076998695) / 29.530588853);
    var monthStart = getNewMoonDay(k + 1, timeZone);

    if (monthStart > dayNumber) {
      monthStart = getNewMoonDay(k, timeZone);
    }

    var a11 = getLunarMonth11(yy, timeZone);
    final b11 = a11;

    int lunarYear;
    if (a11 >= monthStart) {
      lunarYear = yy;
      a11 = getLunarMonth11(yy - 1, timeZone);
    } else {
      lunarYear = yy + 1;
    }

    final lunarDay = dayNumber - monthStart + 1;
    final diff = _toInt((monthStart - a11) / 29);
    var lunarLeap = 0;
    var lunarMonth = diff + 11;

    if (b11 - a11 > 365) {
      final leapMonthDiff = getLeapMonthOffset(a11, timeZone);
      if (diff >= leapMonthDiff) {
        lunarMonth = diff + 10;
        if (diff == leapMonthDiff) {
          lunarLeap = 1;
        }
      }
    }

    if (lunarMonth > 12) {
      lunarMonth = lunarMonth - 12;
    }
    if (lunarMonth >= 11 && diff < 4) {
      lunarYear -= 1;
    }

    return LunarDate(
      day: lunarDay,
      month: lunarMonth,
      year: lunarYear,
      isLeapMonth: lunarLeap == 1,
    );
  }

  static List<int> lunarToSolar(
    int lunarDay,
    int lunarMonth,
    int lunarYear,
    int lunarLeap,
    double timeZone,
  ) {
    int k, a11, b11, off, leapOff, leapMonth, monthStart;
    if (lunarMonth < 11) {
      a11 = getLunarMonth11(lunarYear - 1, timeZone);
      b11 = getLunarMonth11(lunarYear, timeZone);
    } else {
      a11 = getLunarMonth11(lunarYear, timeZone);
      b11 = getLunarMonth11(lunarYear + 1, timeZone);
    }
    k = _toInt(0.5 + (a11 - 2415021.076998695) / 29.530588853);
    off = lunarMonth - 11;
    if (off < 0) {
      off += 12;
    }
    if (b11 - a11 > 365) {
      leapOff = getLeapMonthOffset(a11, timeZone);
      leapMonth = leapOff - 2;
      if (leapMonth < 0) {
        leapMonth += 12;
      }
      if (lunarLeap != 0 && lunarMonth != leapMonth) {
        return [0, 0, 0];
      } else if (lunarLeap != 0 || off >= leapOff) {
        off += 1;
      }
    }
    monthStart = getNewMoonDay(k + off, timeZone);
    return jdToDate(monthStart + lunarDay - 1);
  }

  /// Tính ngày dương lịch từ ngày Julius
  static List<int> jdToDate(int jd) {
    int a, b, c;
    if (jd > 2299160) {
      a = jd + 32044;
      b = _toInt((4 * a + 3) / 146097);
      c = a - _toInt((b * 146097) / 4);
    } else {
      b = 0;
      c = jd + 32082;
    }

    final d = _toInt((4 * c + 3) / 1461);
    final e = c - _toInt((1461 * d) / 4);
    final m = _toInt((5 * e + 2) / 153);
    final day = e - _toInt((153 * m + 2) / 5) + 1;
    final month = m + 3 - 12 * _toInt(m / 10);
    final year = b * 100 + d - 4800 + _toInt(m / 10);

    return [day, month, year];
  }

  /// Tính ngày Julius từ ngày dương lịch
  static int jdFromDate(int dd, int mm, int yy) {
    final a = _toInt((14 - mm) / 12);
    final y = yy + 4800 - a;
    final m = mm + 12 * a - 3;
    var jd =
        dd +
        _toInt((153 * m + 2) / 5) +
        365 * y +
        _toInt(y / 4) -
        _toInt(y / 100) +
        _toInt(y / 400) -
        32045;

    if (jd < 2299161) {
      jd = dd + _toInt((153 * m + 2) / 5) + 365 * y + _toInt(y / 4) - 32083;
    }
    return jd;
  }

  static int getLeapMonthOffset(int a11, double timeZone) {
    int k, last, arc, i;
    k = _toInt((a11 - 2415021.076998695) / 29.530588853 + 0.5);
    last = 0;
    i = 1; // We start with the month following lunar month 11
    arc = getSunLongitude(getNewMoonDay(k + i, timeZone).toDouble(), timeZone);
    do {
      last = arc;
      i++;
      arc = getSunLongitude(
        getNewMoonDay(k + i, timeZone).toDouble(),
        timeZone,
      );
    } while (arc != last && i < 14);
    return i - 1;
  }

  static int getLunarMonth11(int yy, double timeZone) {
    int k, off, nm, sunLong;
    off = jdFromDate(31, 12, yy) - 2415021;
    k = _toInt(off / 29.530588853);
    nm = getNewMoonDay(k, timeZone);
    sunLong = getSunLongitude(
      nm.toDouble(),
      timeZone,
    ); // sun longitude at local midnight
    if (sunLong >= 9) {
      nm = getNewMoonDay(k - 1, timeZone);
    }
    return nm;
  }

  static int getSunLongitude(double dayNumber, double timeZone) {
    return _toInt(sunLongitude(dayNumber - 0.5 - timeZone / 24) / pi * 6);
  }

  static double sunLongitude(double jdn) {
    // ignore: non_constant_identifier_names
    double T, T2, dr, M, L0, DL, L;
    T =
        (jdn - 2451545.0) /
        36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    T2 = T * T;
    dr = pi / 180; // degree to radian
    M =
        357.52910 +
        35999.05030 * T -
        0.0001559 * T2 -
        0.00000048 * T * T2; // mean anomaly, degree
    L0 = 280.46645 + 36000.76983 * T + 0.0003032 * T2; // mean longitude, degree
    DL = (1.914600 - 0.004817 * T - 0.000014 * T2) * sin(dr * M);
    DL =
        DL +
        (0.019993 - 0.000101 * T) * sin(dr * 2 * M) +
        0.000290 * sin(dr * 3 * M);
    L = L0 + DL; // true longitude, degree
    L = L * dr;
    L = L - pi * 2 * (_toInt(L / (pi * 2)));
    return L;
  }

  static int _toInt(double d) => d.toInt();

  static int getNewMoonDay(int k, double timeZone) {
    return _toInt(newMoon(k) + 0.5 + timeZone / 24);
  }

  static double newMoon(int k) {
    // ignore: non_constant_identifier_names
    double T, T2, T3, dr, Jd1, M, Mpr, F, C1, delta, JdNew;
    T = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
    T2 = T * T;
    T3 = T2 * T;
    dr = pi / 180;
    Jd1 = 2415020.75933 + 29.53058868 * k + 0.0001178 * T2 - 0.000000155 * T3;
    Jd1 =
        Jd1 +
        0.00033 *
            sin((166.56 + 132.87 * T - 0.009173 * T2) * dr); // Mean new moon
    M =
        359.2242 +
        29.10535608 * k -
        0.0000333 * T2 -
        0.00000347 * T3; // Sun's mean anomaly
    Mpr =
        306.0253 +
        385.81691806 * k +
        0.0107306 * T2 +
        0.00001236 * T3; // Moon's mean anomaly
    F =
        21.2964 +
        390.67050646 * k -
        0.0016528 * T2 -
        0.00000239 * T3; // Moon's argument of latitude
    C1 = (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
    C1 = C1 - 0.4068 * sin(Mpr * dr) + 0.0161 * sin(dr * 2 * Mpr);
    C1 = C1 - 0.0004 * sin(dr * 3 * Mpr);
    C1 = C1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + Mpr));
    C1 = C1 - 0.0074 * sin(dr * (M - Mpr)) + 0.0004 * sin(dr * (2 * F + M));
    C1 = C1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + Mpr));
    C1 =
        C1 +
        0.0010 * sin(dr * (2 * F - Mpr)) +
        0.0005 * sin(dr * (2 * Mpr + M));
    if (T < -11) {
      delta =
          0.001 +
          0.000839 * T +
          0.0002261 * T2 -
          0.00000845 * T3 -
          0.000000081 * T * T3;
    } else {
      delta = -0.000278 + 0.000265 * T + 0.000262 * T2;
    }

    JdNew = Jd1 + C1 - delta;
    return JdNew;
  }
}

/// Model biểu diễn ngày âm lịch
class LunarDate {
  /// Ngày âm lịch (1-30)
  final int day;

  /// Tháng âm lịch (1-12)
  final int month;

  /// Năm âm lịch
  final int year;

  /// Can chi của ngày (ví dụ: Giáp Tý)
  final String? canChi;

  /// Có phải tháng nhuận không
  final bool isLeapMonth;

  /// Constructor
  const LunarDate({
    required this.day,
    required this.month,
    required this.year,
    this.canChi,
    this.isLeapMonth = false,
  });

  /// Tạo LunarDate từ DateTime (dương lịch)
  static LunarDate fromSolar(DateTime solarDate) {
    return LunarUtils.solarToLunar(solarDate);
  }

  /// Chuyển đổi sang DateTime (dương lịch)
  DateTime toSolar() {
    final currentTimeZone = DateTime.now().timeZoneOffset.inHours;
    final date = LunarUtils.lunarToSolar(
      day,
      month,
      year,
      isLeapMonth ? 1 : 0,
      currentTimeZone.toDouble(),
    );
    return DateTime(date[2], date[1], date[0]);
  }

  LunarDate copyWith({
    int? day,
    int? month,
    int? year,
    String? canChi,
    bool? isLeapMonth,
  }) {
    return LunarDate(
      day: day ?? this.day,
      month: month ?? this.month,
      year: year ?? this.year,
      canChi: canChi ?? this.canChi,
      isLeapMonth: isLeapMonth ?? this.isLeapMonth,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LunarDate &&
        other.day == day &&
        other.month == month &&
        other.year == year &&
        other.isLeapMonth == isLeapMonth;
  }

  @override
  int get hashCode {
    return Object.hash(day, month, year, isLeapMonth);
  }

  @override
  String toString() {
    final leapStr = isLeapMonth ? ' (nhuận)' : '';
    final canChiStr = canChi != null ? ' $canChi' : '';
    return '$day/$month$leapStr/$year$canChiStr';
  }

  factory LunarDate.fromJson(Map<String, dynamic> json) {
    return LunarDate(
      day: json['day'] as int,
      month: json['month'] as int,
      year: json['year'] as int,
      canChi: json['canChi'] as String?,
      isLeapMonth: json['isLeapMonth'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'month': month,
      'year': year,
      'canChi': canChi,
      'isLeapMonth': isLeapMonth,
    };
  }

  bool isValid() {
    if (month < 1 || month > 12) return false;
    if (day < 1 || day > 30) return false; // Tạm thời giới hạn 30 ngày/tháng
    return true;
  }
}
