import 'package:flutter/material.dart';

class TimeAndClassHeader extends StatelessWidget {
  const TimeAndClassHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const headerStyle = TextStyle(
      color: Color(0xFF3C3C3C),
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
    );
    return Row(
      children: const [
        Text("Time", style: headerStyle),
        SizedBox(width: 50),
        Text("Class", style: headerStyle),
      ],
    );
  }
}
