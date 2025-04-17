// lib/widgets/coming_soon_widget.dart

import 'package:flutter/material.dart';
import 'package:MySchool/core/constants.dart';

class ComingSoonWidget extends StatelessWidget {
  final String title;

  const ComingSoonWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: AppColors.kSecondaryColor),
            const SizedBox(height: 20),
            Text(
              "Coming Soon...",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.kSecondaryColor,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "This section is under development.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
