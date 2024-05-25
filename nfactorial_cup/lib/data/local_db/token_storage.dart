import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  final SharedPreferences prefs;

  TokenStorage({
    required this.prefs,
  }) {
    _loadToken();
  }

  get token => _token;
  String? _token;
  static const String _tokenKey = 'gpt_token_key';

  Future<bool> setToken(String token) async {
    _token = token;
    return await prefs.setString(_tokenKey, token);
  }

  void _loadToken() async {
    _token = prefs.getString(_tokenKey);
  }

  Future<bool> clearToken() async {
    _token = '';
    return await prefs.remove(_tokenKey);
  }
}
