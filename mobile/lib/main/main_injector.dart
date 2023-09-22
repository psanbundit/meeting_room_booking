import 'package:meeting_room_booking/common/bloc/application_cubit.dart';
import 'package:meeting_room_booking/pages/search_room/bloc/search_room_cubit.dart';
import 'package:root_dependencies/root_dependencies.dart';

class MainInjector extends BlocInjector {
  @override
  injectBlocs(InjectBloc inject) {
    inject(ApplicationCubit());
    inject(SerachRoomPageCubit(), lazy: true);
  }
}

class ApplicationMixin {
  final application = SystemDependencies.of<ApplicationCubit>();
}
