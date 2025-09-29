import 'package:injectable/injectable.dart';

import '../base/base_cubit.dart';
import 'list_interest_state.dart';

@Injectable()
class ListInterestCubit extends BaseCubit<ListInterestState> {
  bool isLoading = false;

  ListInterestCubit() : super(ListInterestState.initial());

  void getListInterest(int page) {}
}
