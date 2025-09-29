import 'package:injectable/injectable.dart';

import '../base/base_cubit.dart';
import 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeState> {
  HomeCubit() : super(HomeState.initial());
}
