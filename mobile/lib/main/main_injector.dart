import 'package:meeting_room_booking/common/bloc/application_cubit.dart';
import 'package:root_dependencies/root_dependencies.dart';

class MainInjector extends BlocInjector {
  @override
  injectBlocs(InjectBloc inject) {
    inject(ApplicationCubit());
  }
}

class ApplicationMixin {
  final application = SystemDependencies.of<ApplicationCubit>();
}
