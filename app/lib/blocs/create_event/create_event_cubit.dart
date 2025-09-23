import 'package:injectable/injectable.dart';

import '../base/base_cubit.dart';
import 'create_event_state.dart';

@Injectable()
class CreateEventCubit extends BaseCubit<CreateEventState> {
  CreateEventCubit() : super(CreateEventState.initial());
}
