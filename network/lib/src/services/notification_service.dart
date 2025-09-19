import 'package:injectable/injectable.dart';
import 'package:network/network.dart';


@LazySingleton()
class NotificationService {
  final AuthAppServerApiClient _authAppServerApiClient;

  NotificationService(this._authAppServerApiClient);

  Future<DataListResponse<ApiNotificationData>?> getNotifications({
    required int type,
  }) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: '/notifications',
      queryParameters: {'type': type},
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      decoder: (json) => ApiNotificationData.fromJson(json as Map<String, dynamic>),
    );
  }
}
