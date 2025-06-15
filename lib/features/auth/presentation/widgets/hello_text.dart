import 'package:MySchool/core/constants/constants.dart';
import 'package:flutter/material.dart';

class HelloText extends StatelessWidget {
  const HelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello, Login to continue using our app",
      style: TextStyle(color: AppColors.kSecondaryColor, fontSize: 16),
    );
  }
}
