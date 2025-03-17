import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  final String image;
  final String title;
  final int color;
  

  const IntroPage({super.key, 
    required this.image,
    required this.title,
    required this.color
  
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(color),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Image.asset(
              image,
              height: 300,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}