import 'package:injectable/injectable.dart';
import 'package:shared/shared.dart';

import '../base/base_cubit.dart';
import 'common_state.dart';

@Injectable()
class CommonCubit extends BaseCubit<CommonState> {
  CommonCubit() : super(const CommonState());

  void onLoadingVisibilityEmitted({required bool isLoading}) {
    if (isLoading == state.isLoading) {
      return;
    }
    emit(state.copyWith(isLoading: isLoading));
  }

  void onExceptionEmitted({required AppExceptionWrapper appExceptionWrapper}) {
    emit(state.copyWith(appExceptionWrapper: appExceptionWrapper));
  }
}
