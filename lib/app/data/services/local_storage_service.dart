import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';

  static LocalStorageService? _instance;
  static SharedPreferences? _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _preferences = await SharedPreferences.getInstance();
      _instance = LocalStorageService._();
    }
    return _instance!;
  }

  LocalStorageService._();

  Future<void> saveToken(String token) async {
    await _preferences?.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    return _preferences?.getString(_tokenKey);
  }

  Future<void> deleteToken() async {
    await _preferences?.remove(_tokenKey);
  }
}
