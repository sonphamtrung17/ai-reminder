import 'package:injectable/injectable.dart';

import '../base/base_cubit.dart';
import 'main_state.dart';

@LazySingleton()
class MainCubit extends BaseCubit<MainState> {
  MainCubit() : super(const MainState());

  void setHeightBottomNavigationBar(double heightBottomNavigationBar) {
    emit(state.copyWith(heightBottomNavigationBar: heightBottomNavigationBar));
  }
}
