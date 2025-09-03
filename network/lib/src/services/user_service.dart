import 'package:injectable/injectable.dart';
import 'package:network/network.dart';

@LazySingleton()
class UserService {
  final AuthAppServerApiClient _authAppServerApiClient;

  UserService(this._authAppServerApiClient);

  Future<DataListResponse<ApiUserData>?> getUsers({
    required int page,
    required int? limit,
  }) {
    return _authAppServerApiClient.request(
      method: RestMethod.get,
      path: '/user',
      queryParameters: {'page': page, 'results': limit},
      successResponseMapperType: SuccessResponseMapperType.dataJsonArray,
      decoder: (json) => ApiUserData.fromJson(json as Map<String, dynamic>),
    );
  }
}
