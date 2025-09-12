import '../base/base_cubit.dart';
import 'list_interest_state.dart';

class ListInterestCubit extends BaseCubit<ListInterestState> {
  bool isLoading = false;

  ListInterestCubit() : super(ListInterestState.initial());

  void getListInterest(int page) {}
}
