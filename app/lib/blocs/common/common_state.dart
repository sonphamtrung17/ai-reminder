import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared/shared.dart';

import '../base/base_cubit_state.dart';

part 'common_state.freezed.dart';

@freezed
sealed class CommonState extends BaseCubitState with _$CommonState {
  const CommonState._();

  const factory CommonState({
    AppExceptionWrapper? appExceptionWrapper,
    @Default(false) bool isLoading,
  }) = _CommonState;
}
