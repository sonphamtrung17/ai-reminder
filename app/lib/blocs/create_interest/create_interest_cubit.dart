import '../base/base_cubit.dart';
import 'create_interest_state.dart';

class CreateInterestCubit extends BaseCubit<CreateInterestState> {
  bool isLoading = false;

  CreateInterestCubit() : super(CreateInterestState.initial());

  void createInterest(int page) {}
}
