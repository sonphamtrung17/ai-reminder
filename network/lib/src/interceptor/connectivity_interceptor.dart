import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'package:shared/shared.dart';
import 'base_interceptor.dart';

@Injectable()
class ConnectivityInterceptor extends BaseInterceptor {
  @override
  int get priority => BaseInterceptor.connectivityPriority;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final result = await InternetAddress.lookup('apple.com');
      final isConnected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      if (!isConnected) {
        return handler.reject(
          DioException(
            requestOptions: options,
            error: const RemoteException(kind: RemoteExceptionKind.noInternet),
          ),
        );
      }
    } on SocketException catch (_) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const RemoteException(kind: RemoteExceptionKind.noInternet),
        ),
      );
    }

    return super.onRequest(options, handler);
  }
}
