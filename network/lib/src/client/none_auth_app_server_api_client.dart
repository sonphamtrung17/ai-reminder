import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:network/src/client/rest_api_client.dart';
import 'package:network/src/interceptor/header_interceptor.dart';

import 'package:shared/shared.dart';

import 'base/dio_builder.dart';

@LazySingleton()
class NoneAuthAppServerApiClient extends RestApiClient {
  NoneAuthAppServerApiClient(HeaderInterceptor headerInterceptor)
    : super(
        dio: DioBuilder.createDio(
          options: BaseOptions(baseUrl: UrlConstants.appApiBaseUrl),
          interceptors: [headerInterceptor],
        ),
      );
}
