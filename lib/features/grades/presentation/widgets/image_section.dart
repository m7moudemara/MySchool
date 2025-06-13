import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({
    super.key,
    required this.imageUrl,
    required this.studentName,
    required this.className,
  });

  final String imageUrl;
  final String studentName;
  final String className;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage('assets/profile.png'),
          // backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(height: 10),
        Text(
          studentName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'League Spartan',
          ),
        ),
        Text(
          className,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontFamily: 'League Spartan',
          ),
        ),
      ],
    );
  }
}
