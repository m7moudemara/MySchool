import 'package:flutter/material.dart';

class Lesson {
  final String time;
  final String endTime;
  final String teacher;
  final String subject;
  final Color color;
  final bool isBreak;

  Lesson({
    required this.time,
    required this.endTime,
    required this.teacher,
    required this.subject,
    required this.color,
    required this.isBreak,
  });
}