import 'package:network/network.dart';

import '../base/base_cubit.dart';
import 'list_interest_state.dart';

class ListInterestCubit extends BaseCubit<ListInterestState> {
  final UserService _userService;
  bool isLoading = false;

  ListInterestCubit(this._userService) : super(ListInterestState.initial());

  void getListInterest(int page) {}
}


