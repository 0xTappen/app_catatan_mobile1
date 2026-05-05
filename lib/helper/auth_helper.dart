import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static const _KeyLoggedIn = 'is_logged_in';
  static const _KeyUsername = 'username';

  static const _validUsername = 'admin';
  static const _validPassword = 'admin123';

  static Future<bool> login(String username, String password) async {
    if (username == _validUsername && password == _validPassword) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_KeyLoggedIn, true);
      await prefs.setString(_KeyUsername, username);
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_KeyLoggedIn);
    await prefs.remove(_KeyUsername);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_KeyLoggedIn) ?? false;
  }

  static Future<String> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_KeyUsername) ?? '';
  }
}
