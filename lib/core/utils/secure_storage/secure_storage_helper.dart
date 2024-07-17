import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage(iOptions: IOSOptions(),aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ),);
  static final SecureStorage _instance = SecureStorage._internal();

  factory SecureStorage() => _instance;

  SecureStorage._internal();

  Future<void> setToken(String token) async {
    await _storage.write(key: 'token', value: token);
  }


  Future<String?> getToken() async {
    return await _storage.read(key: 'token');
  }
  Future<void> setUrl(String url) async {
    await _storage.write(key: 'url', value: url);
  }
  Future<String?> getUrl() async {
    return await _storage.read(key: 'url');
  }

  Future<bool> hasToken() async {
    final token = await getToken();
    return token != null;
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: 'token');
  }

  Future<void> setRefreshToken(String token) async {
    await _storage.write(key: 'REFRESH_TOKEN', value: token);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'REFRESH_TOKEN');
  }

  Future<bool> hasRefreshToken() async {
    final token = await getRefreshToken();
    return token != null;
  }

  Future<void> deleteRefreshToken() async {
    await _storage.delete(key: 'REFRESH_TOKEN');
  }

  Future<void> setUserId(String token) async {
    await _storage.write(key: 'USER_ID', value: token);
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: 'USER_ID');
  }

  Future<bool> hasUserId() async {
    final token = await getUserId();
    return token != null;
  }

  Future<void> deleteUserId() async {
    await _storage.delete(key: 'USER_ID');
  }
  Future<void> setDeviceId(String token) async {
    await _storage.write(key: 'DEVICE_ID', value: token);
  }

  Future<String?> getDeviceId() async {
    return await _storage.read(key: 'DEVICE_ID');
  }

  Future<bool> hasDeviceId() async {
    final token = await getDeviceId();
    return token != null;
  }

  Future<void> deleteDeviceId() async {
    await _storage.delete(key: 'DEVICE_ID');
  }

}
