import 'package:injectable/injectable.dart';

import '../base/base_cubit.dart';
import 'create_interest_state.dart';

@Injectable()
class CreateInterestCubit extends BaseCubit<CreateInterestState> {
  bool isLoading = false;

  CreateInterestCubit() : super(CreateInterestState.initial());

  void createInterest(int page) {}
}
