import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  FlutterSecureStorage storage = FlutterSecureStorage();

  void writeToStorage(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> readFromStorage(String key) async {
    String? keyRead = await storage.read(key: key);
    return keyRead;
  }

  deleteAll() {
    storage.deleteAll();
  }
}
