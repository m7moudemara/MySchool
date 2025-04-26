import 'package:flutter/material.dart';

class LessonEntity {
  final String time;
  final String endTime;
  final String teacher;
  final String subject;
  final Color color;
  final bool isBreak;

  LessonEntity({
    required this.time,
    required this.endTime,
    required this.teacher,
    required this.subject,
    required this.color,
    required this.isBreak,
  });
}