import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _tokenKey = 'auth_token';
  static const String keyIsLoggedIn = 'is_logged_in';
  static const String keyemail = 'logged_in_email';
  static const String validemail = 'gita@gmail.com';

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  static Future<String?> getLoggedInemail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyemail);
  }

  static Future<bool> login(String email, String password) async {
    if (email == validemail && password == '123') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(keyIsLoggedIn, true);
      await prefs.setString(keyemail, email);
      return true;
    }
    return false;
  }
  
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyIsLoggedIn);
    await prefs.remove(keyemail);
  }
}