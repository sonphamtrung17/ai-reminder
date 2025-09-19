import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_notification_data.freezed.dart';
part 'api_notification_data.g.dart';

@freezed
sealed class ApiNotificationData with _$ApiNotificationData {
  const ApiNotificationData._();

  const factory ApiNotificationData({
    @JsonKey(name: 'id') int? id,
    @JsonKey(name: 'user_id') int? userId,
    @JsonKey(name: 'title') String? title,
    @JsonKey(name: 'message') String? message,
    @JsonKey(name: 'type') int? type,
    @JsonKey(name: 'is_read') bool? isRead,
    @JsonKey(name: 'created_at') String? createdAt,
  }) = _ApiNotificationData;

  factory ApiNotificationData.fromJson(Map<String, dynamic> json) => _$ApiNotificationDataFromJson(json);
}
