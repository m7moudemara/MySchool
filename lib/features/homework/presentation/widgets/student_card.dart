import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String name;
  final String number;
  final String imageUrl;
  final bool submitted;

  const StudentCard({
    super.key,
    required this.name,
    required this.number,
    required this.imageUrl,
    required this.submitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: submitted ? const Color(0xFF0C46C4) : const Color(0xFFF2ABFE),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 4),
            color: Color(0x3F000000),
          ),
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            'assets/profile.png',
            width: 42,
            height: 40,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15.5,
          ),
        ),
        subtitle: Text(
          number,
          style: TextStyle(color: Colors.white.withAlpha(235), fontSize: 12.35),
        ),
        trailing:
            submitted
                ? IconButton(
                  onPressed: () {
                    // Todo download The Submitted Homework
                  },
                  icon: Icon(Icons.download, color: Colors.white),
                )
                : SizedBox(),
      ),
    );
  }
}
