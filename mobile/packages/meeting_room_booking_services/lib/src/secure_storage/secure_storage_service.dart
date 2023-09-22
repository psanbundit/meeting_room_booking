part of meeting_room_booking_services;

class SecureStorageService {
  final _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock,
    ),
  );

  Future<String?> read({required String key}) async {
    return await _secureStorage.read(
      key: key,
    );
  }

  Future<void> write({required String key, required String? value}) async {
    await _secureStorage.write(
      key: key,
      value: value,
    );
  }

  Future<void> delete({required String key}) async {
    await _secureStorage.delete(
      key: key,
    );
  }
}
