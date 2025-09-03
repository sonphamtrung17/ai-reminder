import 'package:injectable/injectable.dart';
import 'package:network/network.dart';
import 'package:shared/shared.dart';

import '../base/base_cubit.dart';
import 'splash_state.dart';

@Injectable()
class SplashCubit extends BaseCubit<SplashState> {
  final UserService _userService;

  SplashCubit(this._userService) : super(SplashState());

  void getUsers(int page) {
    runBlocCatching(
      action: () async {
        final output = await _userService.getUsers(page: page, limit: 10);
        Log.d(output);
        // output.data
        // emit(state.copyWith(users: output));
      },
      doOnError: (e) async {
        // emit(state.copyWith(loadUsersException: e));
      },
      doOnSubscribe: () async => emit(state.copyWith(isShimmerLoading: true)),
      doOnSuccessOrError: () async =>
          emit(state.copyWith(isShimmerLoading: false)),
      handleLoading: false,
      maxRetries: 3,
    );
  }
}
