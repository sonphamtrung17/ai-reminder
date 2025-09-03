import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:network/src/interceptor/connectivity_interceptor.dart';
import 'package:network/src/interceptor/custom_log_interceptor.dart';
import 'package:network/src/interceptor/retry_on_error_interceptor.dart';
import 'package:network/src/mapper/base/base_error_response_mapper.dart';
import 'package:network/src/mapper/base/base_success_response_mapper.dart';

class ApiClientDefaultSetting {
  const ApiClientDefaultSetting._();

  static const defaultErrorResponseMapperType =
      ErrorResponseMapperType.jsonObject;
  static const defaultSuccessResponseMapperType =
      SuccessResponseMapperType.dataJsonObject;

  // required interceptors
  static List<Interceptor> requiredInterceptors(Dio dio) => [
    if (kDebugMode) CustomLogInterceptor(),
    ConnectivityInterceptor(),
    RetryOnErrorInterceptor(dio),
  ];
}
