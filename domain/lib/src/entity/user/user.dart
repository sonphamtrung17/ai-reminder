import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'user.freezed.dart';

@freezed
sealed class User with _$User {
  const factory User({
    @Default(User.defaultId) int id,
    @Default(User.defaultEmail) String email,
    @Default(User.defaultBirthday) DateTime? birthday,
    @Default(User.defaultAvatar) String avatar,
    @Default(User.defaultPhotos) List<String> photos,
    @Default(User.defaultGender) Gender gender,
  }) = _User;

  static const defaultId = 0;
  static const defaultEmail = '';
  static const DateTime? defaultBirthday = null;
  static const defaultAvatar = '';
  static const defaultPhotos = <String>[];
  static const defaultGender = Gender.defaultValue;
}
