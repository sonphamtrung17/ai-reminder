import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int selectedDay = 18;

  void _navigateToDetail(int day) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            DayDetailScreen(day: day),
        transitionDuration: Duration(milliseconds: 500),
        reverseTransitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back_ios, color: Colors.black),
        title: Text(
          '2025',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          Icon(Icons.menu, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 10),
          Icon(Icons.add, color: Colors.black),
          SizedBox(width: 15),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Tháng 9',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // Header các ngày trong tuần
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN']
                  .map((day) => Container(
                width: 40,
                child: Text(
                  day,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ))
                  .toList(),
            ),
          ),
          SizedBox(height: 20),
          // Calendar grid
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  childAspectRatio: 1,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 10,
                ),
                itemCount: 30,
                itemBuilder: (context, index) {
                  int day = index + 1;
                  bool isSelected = day == selectedDay;
                  bool hasEvent = [18, 19, 20, 21, 22, 23, 24, 25, 26].contains(day);

                  return CalendarDay(
                    day: day,
                    isSelected: isSelected,
                    hasEvent: hasEvent,
                    onTap: () {
                      setState(() {
                        selectedDay = day;
                      });
                      _navigateToDetail(day);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DayDetailScreen extends StatelessWidget {
  final int day;

  DayDetailScreen({required this.day});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Top section với ngày được chọn
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // Back button và title
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.arrow_back_ios, color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Tháng 9, 2025',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(width: 40), // Balance the back button
                    ],
                  ),
                  SizedBox(height: 30),

                  // Hero animated day
                  Hero(
                    tag: 'day_$day',
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                              offset: Offset(0, 5),
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              spreadRadius: 2,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            '$day',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  Text(
                    'Thứ ${(day % 7) + 2}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            // Content section
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sự kiện trong ngày',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Example events
                      if ([18, 19, 20, 21, 22, 23, 24, 25, 26].contains(day))
                        _buildEventCard('Meeting với team', '10:00 AM', Colors.blue)
                      else
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Center(
                            child: Text(
                              'Không có sự kiện nào',
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(String title, String time, Color color) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarDay extends StatefulWidget {
  final int day;
  final bool isSelected;
  final bool hasEvent;
  final VoidCallback onTap;

  CalendarDay({
    required this.day,
    required this.isSelected,
    required this.hasEvent,
    required this.onTap,
  });

  @override
  _CalendarDayState createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _scaleController;
  late Animation<double> _rippleAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _rippleController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 150),
      vsync: this,
    );

    _rippleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.6,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _rippleController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _handleTap() {
    // Reset animations
    _rippleController.reset();
    _scaleController.reset();

    // Start scale down animation
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    // Start ripple animation
    _rippleController.forward();

    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 50,
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ripple effect
            AnimatedBuilder(
              animation: _rippleController,
              builder: (context, child) {
                if (_rippleAnimation.value == 0) return SizedBox.shrink();

                return Container(
                  width: 50 + (30 * _rippleAnimation.value),
                  height: 50 + (30 * _rippleAnimation.value),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (widget.isSelected ? Colors.red : Colors.blue)
                        .withOpacity(_opacityAnimation.value),
                  ),
                );
              },
            ),

            // Hero wrapped day container
            Hero(
              tag: 'day_${widget.day}',
              child: Material(
                color: Colors.transparent,
                child: AnimatedBuilder(
                  animation: _scaleController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.isSelected ? Colors.red : Colors.transparent,
                          boxShadow: widget.isSelected
                              ? [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.3),
                              blurRadius: 8,
                              spreadRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            '${widget.day}',
                            style: TextStyle(
                              color: widget.isSelected ? Colors.white : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Event indicator
            if (widget.hasEvent && !widget.isSelected)
              Positioned(
                bottom: 5,
                child: Container(
                  width: 4,
                  height: 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}