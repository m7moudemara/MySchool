import 'package:flutter/material.dart';

class LessonEntity {
  final String time;
  final String endTime;
  final String subject;
  final String teacher;
  final String classId;
  final Color color;
  final bool isBreak;

  LessonEntity({
    required this.time,
    required this.endTime,
    required this.subject,
    required this.teacher,
    required this.classId,
    required this.color,
    required this.isBreak,
  });
}