import 'package:domain/domain.dart';
import 'package:shared/shared.dart';

abstract class ExceptionHandlerListener {
  void onRefreshTokenFailed();
}

class ExceptionHandler {
  const ExceptionHandler({required this.listener, required this.navigator});

  final ExceptionHandlerListener listener;
  final AppNavigator navigator;

  Future<void> handleException(
    AppExceptionWrapper appExceptionWrapper,
    String commonExceptionMessage,
  ) async {
    final message =
        appExceptionWrapper.overrideMessage ?? commonExceptionMessage;

    switch (appExceptionWrapper.appException.appExceptionType) {
      case AppExceptionType.remote:
        final exception = appExceptionWrapper.appException as RemoteException;
        switch (exception.kind) {
          case RemoteExceptionKind.refreshTokenFailed:
            await _showErrorDialog(
              isRefreshTokenFailed: true,
              message: message,
              onPressed: () {
                navigator.pop();
              },
            );
            break;
          case RemoteExceptionKind.noInternet:
          case RemoteExceptionKind.timeout:
            await _showErrorDialogWithRetry(
              message: message,
              onRetryPressed: () async {
                navigator.pop();
                await appExceptionWrapper.doOnRetry?.call();
              },
            );
            break;
          default:
            await _showErrorDialog(message: message);
            break;
        }
        break;
      case AppExceptionType.parse:
        return _showErrorSnackBar(message: message);
      case AppExceptionType.remoteConfig:
        return _showErrorSnackBar(message: message);
      case AppExceptionType.uncaught:
        return;
      case AppExceptionType.validation:
        await _showErrorDialog(message: message);
        break;
    }
  }

  void _showErrorSnackBar({
    required String message,
    Duration duration = DurationConstants.defaultErrorVisibleDuration,
  }) {
    navigator.showErrorSnackBar(message, duration: duration);
  }

  Future<void> _showErrorDialog({
    required String message,
    Function? onPressed,
    bool isRefreshTokenFailed = false,
  }) async {
    await navigator
        .showDialog(
          AppPopupInfo.confirmDialog(message: message, onPressed: onPressed),
        )
        .then((value) {
          if (isRefreshTokenFailed) {
            listener.onRefreshTokenFailed();
          }
        });
  }

  Future<void> _showErrorDialogWithRetry({
    required String message,
    required Function onRetryPressed,
  }) async {
    await navigator.showDialog(
      AppPopupInfo.errorWithRetryDialog(
        message: message,
        onRetryPressed: onRetryPressed,
      ),
    );
  }
}
