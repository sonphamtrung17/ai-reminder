import 'package:injectable/injectable.dart';

import '../base/base_cubit.dart';
import 'list_event_state.dart';

@Injectable()
class ListEventCubit extends BaseCubit<ListEventState> {
  ListEventCubit() : super(ListEventState.initial());
}
