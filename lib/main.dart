import 'package:flutter/material.dart';
import 'package:my_school/views/forget_password_view.dart';
import 'package:my_school/views/login_view.dart';
import 'package:my_school/views/select_account_view.dart';
import 'package:my_school/views/sign_up_view.dart';
import 'package:my_school/views/splash_screen.dart';
import 'package:my_school/views/test.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context)=> SplashView(),
        '/SelectedAccountView' : (cotext)=> SelectedAccountView(),
        '/SignUpView' : (context) => SignUpView(),
        '/LoginView': (context) => LoginView(),
        '/ForgetPasswordView' : (context)=> ForgetPasswordView(),
      },
      initialRoute: '/',
    ),
  );
}
