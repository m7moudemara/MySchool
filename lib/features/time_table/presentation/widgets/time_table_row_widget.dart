import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';
import 'package:flutter/material.dart';

class TimeTableRowWidget extends StatelessWidget {
  final LessonEntity className;
  final double space;
  final double height;
  final bool isFirstItem;
  final bool isLastItem;

  const TimeTableRowWidget({
    super.key,
    required this.className,
    required this.space,
    required this.height,
    required this.isFirstItem,
    required this.isLastItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: space + 2),
                child: Text('Time', style: startTimeStyle),
              ),
            ],
          ),
        ),

        isFirstItem
            ? SizedBox(height: height)
            : Column(
              children: [
                Column(
                  children: [
                    Container(
                      width: 2,
                      height: height,
                      color: const Color(0xff3620C2),
                    ),
                  ],
                ),
              ],
            ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("Class ${className.classId}", style: startTimeStyle),
            ],
          ),
        ),
      ],
    );
  }
}

const startTimeStyle = TextStyle(
  color: Color(0xFF3C3C3C),
  fontSize: 16,
  fontFamily: 'Poppins',
  fontWeight: FontWeight.w600,
);
