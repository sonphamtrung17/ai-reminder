import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

import '../base/base_cubit.dart';
import 'notification_state.dart';

@Injectable()
class NotificationCubit extends BaseCubit<NotificationState> {
  bool isLoading = false;
  final NotificationService _notificationService;

  NotificationCubit(this._notificationService) : super(NotificationState.initial());

  void getNotifications(int type) {
    // runBlocCatching(
    //   action: () async {
    //     final output = await _notificationService.getNotifications(type: type);
    //     final a = output?.data?.map((e) => ApiNotificationDataMapper().mapToEntity(e));
    //     Log.d(output);
    //     // output.data
    //     emit(NotificationState.getNotificationSucceed((a ?? []).toList()));
    //   },
    //   doOnError: (e) async {
    //     // emit(state.copyWith(loadUsersException: e));
    //   },
    //   handleLoading: false,
    //   maxRetries: 3,
    // );
    final Map<String, dynamic> data = {
      "success": true,
      "data": {
        "items": [
          {
            "id": 1,
            "user_id": 1,
            "title": "New message",
            "message": "You have a new message",
            "type": 1,
            "is_read": false,
            "created_at": "2024-08-01T12:00:00.000000Z",
          },
          {
            "id": 2,
            "user_id": 1,
            "title": "New message",
            "message": "You have a new message",
            "type": 1,
            "is_read": false,
            "created_at": "2024-08-01T12:00:00.000000Z",
          },
          {
            "id": 3,
            "user_id": 1,
            "title": "New message",
            "message": "You have a new message",
            "type": 1,
            "is_read": false,
            "created_at": "2024-08-01T12:00:00.000000Z",
          },
          {
            "id": 4,
            "user_id": 1,
            "title": "New message",
            "message": "You have a new message",
            "type": 1,
            "is_read": false,
            "created_at": "2024-08-01T12:00:00.000000Z",
          },
        ],
        "total": 1,
        "page": 1,
        "per_page": 10,
        "total_pages": 1,
      },
    };
    final notificationDataResponse = data['data']['items'].map((e) => ApiNotificationData.fromJson(e)).toList();
    final List<NotificationEntity> listData = notificationDataResponse.map<NotificationEntity>((e) => ApiNotificationDataMapper().mapToEntity(e)).toList();

    emit(NotificationState.getNotificationSucceed(listData));
  }
}
