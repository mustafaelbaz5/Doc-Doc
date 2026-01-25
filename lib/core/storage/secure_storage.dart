import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveString({
    required final String key,
    required final String value,
  }) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getString({required final String key}) async {
    return await _storage.read(key: key);
  }

  Future<void> clear({required final String key}) async {
    await _storage.delete(key: key);
  }
}
