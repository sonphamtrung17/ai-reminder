import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared/shared.dart';

import '../../exception_handler/exception_handler.dart';
import '../../exception_handler/exception_message_mapper.dart';
import '../../theme/theme.dart';
import '../app/app_cubit.dart';
import '../common/common_cubit.dart';
import '../common/common_state.dart';
import 'base_cubit.dart';

abstract class BaseScreenState<T extends StatefulWidget, B extends BaseCubit>
    extends BaseScreenStateDelegate<T, B>
    with LogMixin {}

abstract class BaseScreenStateDelegate<
  T extends StatefulWidget,
  B extends BaseCubit
>
    extends State<T>
    implements ExceptionHandlerListener {
  final navigator = GetIt.instance.get<AppNavigator>();
  final appCubit = GetIt.instance.get<AppCubit>();
  final exceptionMessageMapper = const ExceptionMessageMapper();
  late final exceptionHandler = ExceptionHandler(
    navigator: navigator,
    listener: this,
  );

  late final CommonCubit commonCubit = GetIt.instance.get<CommonCubit>()
    ..navigator = navigator
    ..appCubit = appCubit
    ..exceptionHandler = exceptionHandler
    ..exceptionMessageMapper = exceptionMessageMapper;

  late final B bloc = GetIt.instance.get<B>()
    ..navigator = navigator
    ..appCubit = appCubit
    ..commonCubit = commonCubit
    ..exceptionHandler = exceptionHandler
    ..exceptionMessageMapper = exceptionMessageMapper;

  bool get isAppWidget => false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => bloc),
        BlocProvider(create: (_) => commonCubit),
      ],
      child: BlocListener<CommonCubit, CommonState>(
        listenWhen: (previous, current) =>
            previous.appExceptionWrapper != current.appExceptionWrapper &&
            current.appExceptionWrapper != null,
        listener: (context, state) {
          _handleException(state.appExceptionWrapper!);
        },
        child: buildPageListeners(
          child: isAppWidget
              ? buildPage(context)
              : Stack(
                  children: [
                    buildPage(context),
                    BlocBuilder<CommonCubit, CommonState>(
                      buildWhen: (previous, current) =>
                          previous.isLoading != current.isLoading,
                      builder: (context, state) => Visibility(
                        visible: state.isLoading,
                        child: buildPageLoading(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget buildPageListeners({required Widget child}) => child;

  Widget buildPageLoading() => Container(
    color: context.color.secondary.withValues(alpha: 0.2),
    child: const Center(child: CircularProgressIndicator()),
  );

  Widget buildPage(BuildContext context);

  void _handleException(AppExceptionWrapper appExceptionWrapper) {
    exceptionHandler
        .handleException(
          appExceptionWrapper,
          _handleExceptionMessage(appExceptionWrapper.appException),
        )
        .then((value) {
          appExceptionWrapper.exceptionCompleter?.complete();
        });
  }

  String _handleExceptionMessage(AppException appException) {
    return exceptionMessageMapper.map(appException);
  }

  @override
  void onRefreshTokenFailed() {
    // commonCubit.add(const ForceLogoutButtonPressed());
  }
}
