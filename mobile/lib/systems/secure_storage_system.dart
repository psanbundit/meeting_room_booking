import 'package:root_dependencies/root_dependencies.dart';
import 'package:meeting_room_booking_services/services.dart';

class SecureStorageSystem extends System {
  @override
  Future<void> createDependencies(SystemDependencies dependencies) async {
    await Future.delayed(Duration.zero);
    final mockSecureStorageParams = args["mock_secure_storage"];
    if (mockSecureStorageParams != null) {
      dependencies.add<SecureStorageService>(
        MockSecureStorageService(Map<String, String?>.from(mockSecureStorageParams)),
      );
    } else {
      dependencies.add<SecureStorageService>(SecureStorageService());
    }
  }
}

class SecureStorageMixin {
  final secureStorage = SystemDependencies.of<SecureStorageService>();
}
