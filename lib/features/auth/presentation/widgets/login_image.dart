import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage("assets/login_image.png"),
      height: 238,
      width: 238,
    );
  }
}
