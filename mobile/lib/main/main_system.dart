import 'package:meeting_room_booking/systems/secure_storage_system.dart';
import 'package:meeting_room_booking/systems/set_orientation_system.dart';
import 'package:meeting_room_booking/systems/translation_system.dart';
import 'package:root_dependencies/root_dependencies.dart';

class MainSystem extends MultiSystem {
  MainSystem()
      : super(
          systems: [
            SecureStorageSystem(),
            TranslationSystem(),
            SetOrientationSystem(),
          ],
        );
}
