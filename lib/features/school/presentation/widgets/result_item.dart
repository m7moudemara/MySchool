import 'package:flutter/material.dart';
import '../../domain/entities/result.dart';

class ResultItem extends StatelessWidget {
  final Result result;

  const ResultItem({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(result.icon, height: 50),
        Text(
          result.subject,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.41,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        Container(
          width: 36.83,
          height: 36.83,
          decoration: ShapeDecoration(
            color: const Color(0xFF103568),
            shape: OvalBorder(),
          ),
          child: Center(
            child: Text(
              result.score.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.57,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
