import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:network/src/client/rest_api_client.dart';
import 'package:network/src/interceptor/access_token_interceptor.dart';
import 'package:network/src/interceptor/header_interceptor.dart';
import 'package:network/src/interceptor/refresh_token_interceptor.dart';

import 'package:shared/shared.dart';

import 'base/dio_builder.dart';

@LazySingleton()
class AuthAppServerApiClient extends RestApiClient {
  AuthAppServerApiClient(
    HeaderInterceptor headerInterceptor,
    AccessTokenInterceptor accessTokenInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
  ) : super(
        dio: DioBuilder.createDio(
          options: BaseOptions(baseUrl: UrlConstants.appApiBaseUrl),
          interceptors: [
            headerInterceptor,
            accessTokenInterceptor,
            refreshTokenInterceptor,
          ],
        ),
      );
}
