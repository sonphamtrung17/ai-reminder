import 'package:injectable/injectable.dart';
import 'package:network/src/client/refresh_token_api_client.dart';
import 'package:network/src/client/rest_api_client.dart';
import 'package:network/src/model/refresh_token_data.dart';
import 'package:shared/shared.dart';

import '../model/data_response.dart';

@LazySingleton()
class RefreshTokenApiService {
  RefreshTokenApiService(this._refreshTokenApiClient);

  final RefreshTokenApiClient _refreshTokenApiClient;

  Future<DataResponse<RefreshTokenData>?> refreshToken(
    String refreshToken,
  ) async {
    try {
      final res = await _refreshTokenApiClient
          .request<RefreshTokenData, DataResponse<RefreshTokenData>>(
            method: RestMethod.post,
            path: '/v1/auth/refresh',
            decoder: (json) =>
                RefreshTokenData.fromJson(json as Map<String, dynamic>),
          );

      return res;
    } catch (e) {
      if (e is RemoteException &&
          (e.kind == RemoteExceptionKind.serverDefined ||
              e.kind == RemoteExceptionKind.serverUndefined)) {
        throw const RemoteException(
          kind: RemoteExceptionKind.refreshTokenFailed,
        );
      }

      rethrow;
    }
  }
}
