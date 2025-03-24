import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  static String id = '/HomeView';
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("No Thing To See Here")),
      body: const SizedBox(),
    );
  }
}
