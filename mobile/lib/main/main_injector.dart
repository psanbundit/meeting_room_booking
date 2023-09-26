import 'package:meeting_room_booking/common/bloc/application_cubit.dart';
import 'package:meeting_room_booking/pages/booking_summary_page/bloc/booking_summary_cubit.dart';
import 'package:meeting_room_booking/pages/my_booking_page/bloc/my_booking_cubit.dart';
import 'package:meeting_room_booking/pages/search_room/bloc/search_room_cubit.dart';
import 'package:root_dependencies/root_dependencies.dart';

class MainInjector extends BlocInjector {
  @override
  injectBlocs(InjectBloc inject) {
    inject(ApplicationCubit());
    inject(SearchRoomPageCubit(), lazy: true);
    inject(BookingSummaryCubit(), lazy: true);
    inject(MyBookingCubit(), lazy: true);
  }
}

class ApplicationMixin {
  final application = SystemDependencies.of<ApplicationCubit>();
}
