import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';

class CustomLessonTile extends StatelessWidget {
  final LessonEntity lesson;
  final bool isFirst;
  final bool isLast;
final int index;

const CustomLessonTile({
  super.key,
  required this.lesson,
  required this.isFirst,
  required this.isLast,
  required this.index, 
});
final List<Color> backgroundColors = const [
  Color(0xFFE8DBFC),
  Color(0xFFFDCFC8),
  Color(0xFFD2CECE),
  Color(0xFFA08593),
];


  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColors[index % backgroundColors.length];

    return SizedBox(
      width: double.infinity,
      child: TimelineTile(
            alignment: TimelineAlign.manual,
        lineXY: 0.2,
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: const LineStyle(
          color: Color(0xff3620C2),
          thickness: 2,
        ),
        afterLineStyle: const LineStyle(
          color: Color(0xff3620C2),
          thickness: 2,
        ),
        indicatorStyle: const IndicatorStyle(
          width: 12,
          color: Color(0xff3620C2),
        ),
        startChild: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Time',
                  style: TextStyle(
                    color: Color(0xFF3C3C3C),
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
               Text(formatTime(lesson.time),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(formatTime(lesson.endTime),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),

              ],
            ),
          ),
        ),
        endChild: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Class ${lesson.classId}",
                style: const TextStyle(
                  color: Color(0xFF3C3C3C),
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(

                  color: bgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.black),
                        SizedBox(width: 4),
                        Text(
                          'Handwriting',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lesson.teacher,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



String formatTime(String timeStr) {
  final time = DateFormat("HH:mm:ss").parse(timeStr);
  return DateFormat("hh:mm a").format(time);
}
