import 'package:domain/domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../base/base_state.dart';

part 'notification_state.freezed.dart';

@freezed
sealed class NotificationState extends BaseState with _$NotificationState {
  const NotificationState._();

  factory NotificationState.initial() = NotificationStateInitial;

  factory NotificationState.getNotificationSucceed(List<NotificationEntity> notifications) =
      GetNotificationSucceedState;
}
