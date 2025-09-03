import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:network/src/client/rest_api_client.dart';
import 'package:network/src/interceptor/access_token_interceptor.dart';
import 'package:network/src/interceptor/header_interceptor.dart';

import 'package:shared/shared.dart';

import 'base/dio_builder.dart';

@LazySingleton()
class RefreshTokenApiClient extends RestApiClient {
  RefreshTokenApiClient(
    HeaderInterceptor headerInterceptor,
    AccessTokenInterceptor accessTokenInterceptor,
  ) : super(
        dio: DioBuilder.createDio(
          options: BaseOptions(baseUrl: UrlConstants.appApiBaseUrl),
          interceptors: [headerInterceptor, accessTokenInterceptor],
        ),
      );
}
