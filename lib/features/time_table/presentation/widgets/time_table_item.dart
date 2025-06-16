import 'package:MySchool/features/time_table/presentation/widgets/line_tile.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/lesson_entity.dart';

class TimeTableItem extends StatelessWidget {
  final LessonEntity lesson;
  final bool isFirstItem;
  final bool isLastItem;
  final double height;
  final double space;
  final int index;

  const TimeTableItem({
    super.key,
    required this.lesson,
    required this.height,
    required this.space,
    this.isFirstItem = false,
    this.isLastItem = false,
    required this.index,
  });
final List<Color> backgroundColors = const [
  Color(0xFFE8DBFC),
  Color(0xFFFFF3CB),
  Color(0xFFC0EED5),
  Color(0xFFE8DBFC),
  Color(0xFFCBA8A0),
  Color(0xFFC0EED5),
  Color(0xFFFED1B5),
];



  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColors[index % backgroundColors.length];
    const startTimeStyle = TextStyle(
      color: Colors.black,
      fontSize: 15.16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );

    const endTimeStyle = TextStyle(
      color: Color(0xFFBAB7C9),
      fontSize: 10.11,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: height / 4),
              Padding(
                padding: EdgeInsets.only(bottom: space),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(formatTime(lesson.time), style: startTimeStyle),
                    Text(formatTime(lesson.endTime), style: endTimeStyle),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              height: height / 2,
              child:
                  isFirstItem
                      ? null
                      : Container(width: 2, color: const Color(0xff3620C2)),
            ),
            Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Color(0xff3620C2),
                    shape: BoxShape.circle,
                  ),
                ),
                if (!isLastItem)
                  Container(
                    width: 2,
                    height: space + (height / 2),
                    color: const Color(0xff3620C2),
                  ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: height,
                  decoration: ShapeDecoration(
                    color: bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.74),
                    ),
                  ),
                  child: Center(
                    child: ListTile(
                      leading: Icon(
                        lesson.isBreak ? Icons.free_breakfast : Icons.person,
                        color: const Color(0xFF3C3C3C),
                      ),
                      title: Text(
                        lesson.subject,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF3C3C3C),
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle:
                          !lesson.isBreak
                              ? Text(
                                lesson.teacher,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xFF5F5F5F),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                              : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
