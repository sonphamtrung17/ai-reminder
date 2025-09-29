import 'package:injectable/injectable.dart';

import '../base/base_cubit.dart';
import 'login_state.dart';

@Injectable()
class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginState.initial());
}
