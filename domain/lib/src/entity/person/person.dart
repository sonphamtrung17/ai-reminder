import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

part 'person.freezed.dart';

@freezed
sealed class Person with _$Person {
  const factory Person({
    @Default(Person.defaultId) int id,
    @Default(Person.defaultEmail) String email,
    @Default(Person.defaultName) String name,
    @Default(Person.defaultRelationship) String relationship,
    @Default(Person.defaultJob) String job,
    @Default(Person.defaultPhone) String phone,
    @Default(Person.defaultAddress) String address,
    @Default(Person.defaultNote) String note,
    @Default(Person.defaultBirthday) DateTime? birthday,
    @Default(Person.defaultAvatar) String avatar,
    @Default(Person.defaultGender) Gender gender,
  }) = _Person;

  static const defaultId = 0;
  static const defaultEmail = '';
  static const defaultName = '';
  static const defaultRelationship = '';
  static const defaultJob = '';
  static const defaultPhone = '';
  static const defaultAddress = '';
  static const defaultNote = '';
  static const DateTime? defaultBirthday = null;
  static const defaultAvatar = '';
  static const defaultGender = Gender.defaultValue;
}
