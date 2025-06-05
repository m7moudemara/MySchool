import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {
  saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

    saveClassName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('className', name);
  }

    Future<String?> getClassName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('className');
  }
}
