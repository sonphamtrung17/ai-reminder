import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_entity.freezed.dart';

@freezed
sealed class NotificationEntity with _$NotificationEntity {
  const factory NotificationEntity({
    @Default(NotificationEntity.defaultId) int id,
    @Default('') String title,
    @Default('') String? message,
    @Default(false) bool isRead,
    @Default('') String createdAt
  }) = _NotificationEntity;

  static const defaultId = 0;
}
