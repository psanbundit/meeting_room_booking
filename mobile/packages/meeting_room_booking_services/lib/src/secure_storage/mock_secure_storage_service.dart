part of meeting_room_booking_services;

class MockSecureStorageService extends SecureStorageService {
  final Map<String, String?> _storedValues;

  MockSecureStorageService(this._storedValues);

  @override
  Future<String?> read({required String key}) async {
    return _storedValues[key];
  }

  @override
  Future<void> write({required String key, required String? value}) async {
    await Future.delayed(Duration.zero);
    _storedValues[key] = value;
  }

  @override
  Future<void> delete({required String key}) async {
    await Future.delayed(Duration.zero);
    _storedValues.remove(key);
  }
}
