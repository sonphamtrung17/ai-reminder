import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared/shared.dart';

import '../../exception_handler/exception_handler.dart';
import '../../exception_handler/exception_message_mapper.dart';
import '../app/app_cubit.dart';
import '../common/common_cubit.dart';
import 'base_state.dart';

abstract class BaseCubit<S extends BaseState> extends BaseCubitDelegate<S> with LogMixin {
  BaseCubit(super.initialState);
}

abstract class BaseCubitDelegate<S extends BaseState> extends Cubit<S> {
  BaseCubitDelegate(super.initialState);

  late AppNavigator navigator;
  late AppCubit appCubit;
  late ExceptionHandler exceptionHandler;
  late ExceptionMessageMapper exceptionMessageMapper;
  late CommonCubit _commonCubit;

  set commonCubit(CommonCubit commonCubit) {
    _commonCubit = commonCubit;
  }

  CommonCubit get commonCubit => this is CommonCubit ? this as CommonCubit : _commonCubit;

  Future<void> addException(AppExceptionWrapper appExceptionWrapper) async {
    commonCubit.onExceptionEmitted(appExceptionWrapper: appExceptionWrapper);
    return appExceptionWrapper.exceptionCompleter?.future;
  }

  void showLoading() {
    commonCubit.onLoadingVisibilityEmitted(isLoading: true);
  }

  void hideLoading() {
    commonCubit.onLoadingVisibilityEmitted(isLoading: false);
  }

  Future<void> runBlocCatching({
    required Future<void> Function() action,
    Future<void> Function()? doOnRetry,
    Future<void> Function(AppException)? doOnError,
    Future<void> Function()? doOnSubscribe,
    Future<void> Function()? doOnSuccessOrError,
    Future<void> Function()? doOnEventCompleted,
    bool handleLoading = true,
    bool handleError = true,
    bool handleRetry = true,
    bool Function(AppException)? forceHandleError,
    String? overrideErrorMessage,
    int? maxRetries,
  }) async {
    assert(maxRetries == null || maxRetries > 0, 'maxRetries must be positive');
    Completer<void>? recursion;
    try {
      await doOnSubscribe?.call();
      if (handleLoading) {
        showLoading();
      }

      await action.call();

      if (handleLoading) {
        hideLoading();
      }
      await doOnSuccessOrError?.call();
    } on AppException catch (e) {
      if (handleLoading) {
        hideLoading();
      }
      await doOnSuccessOrError?.call();
      await doOnError?.call(e);

      if (handleError || (forceHandleError?.call(e) ?? _forceHandleError(e))) {
        await addException(
          AppExceptionWrapper(
            appException: e,
            doOnRetry:
                doOnRetry ??
                (handleRetry && maxRetries != 1
                    ? () async {
                        recursion = Completer();
                        await runBlocCatching(
                          action: action,
                          doOnEventCompleted: doOnEventCompleted,
                          doOnSubscribe: doOnSubscribe,
                          doOnSuccessOrError: doOnSuccessOrError,
                          doOnError: doOnError,
                          doOnRetry: doOnRetry,
                          forceHandleError: forceHandleError,
                          handleError: handleError,
                          handleLoading: handleLoading,
                          handleRetry: handleRetry,
                          overrideErrorMessage: overrideErrorMessage,
                          maxRetries: maxRetries?.minus(1),
                        );
                        recursion?.complete();
                      }
                    : null),
            exceptionCompleter: Completer<void>(),
            overrideMessage: overrideErrorMessage,
          ),
        );
      }
    } finally {
      await recursion?.future;
      await doOnEventCompleted?.call();
    }
  }

  bool _forceHandleError(AppException appException) {
    return appException is RemoteException && appException.kind == RemoteExceptionKind.refreshTokenFailed;
  }
}
