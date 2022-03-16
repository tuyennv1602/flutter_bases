import 'package:shared_preferences/shared_preferences.dart';

const String _tokenKey = "user_token";

///
class TokenProvider {
  TokenProvider(this._preferences);

  final SharedPreferences _preferences;

  String? _token;

  String? get token {
    return _token ?? _preferences.getString(_tokenKey);
  }

  Future<void> setNewToken(String? token) async {
    _token = token;
    await _preferences.setString(_tokenKey, token ?? '');
  }
}
