import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:MySchool/core/presentation/intro/presentation/views/intro_view.dart';
import 'package:MySchool/features/auth/presentation/views/login_view.dart';
import 'package:http/http.dart' as http;

class DeciderView extends StatefulWidget {
  const DeciderView({super.key});

  @override
  State<DeciderView> createState() => _DeciderViewState();
}

class _DeciderViewState extends State<DeciderView> {
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  Future<void> _navigateUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('is_first_time') ?? true;

    if (isFirstTime) {
      await prefs.setBool('is_first_time', false);
      _goTo(const IntroView());
    } else {
      _goTo(const LoginView());
    }
  }

  void _goTo(Widget view) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => view));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  checkUser() async {
    final url = Uri.parse('$baseUrl/api/me/profile');
    final response = await http.get(url,headers: {
      'Authorization' : 'Bearer ${await sharedPrefController.getToken()}',
      'Accept' :'application/json'
    });
    if(response.statusCode == 200){

    }
  }
}
