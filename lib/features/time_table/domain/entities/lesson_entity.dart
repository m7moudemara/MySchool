import 'package:flutter/material.dart';

class LessonEntity {
  final String time;
  final String endTime;
  final String subject;
  final String teacher;
  final String classId;
  final Color color;
  final bool isBreak;
  final int day;

  LessonEntity({
    required this.time,
    required this.endTime,
    required this.subject,
    required this.teacher,
    required this.classId,
    required this.color,
    required this.isBreak,
    required this.day
  });

  factory LessonEntity.fromJson(Map<String, dynamic> json) {
    return LessonEntity(
      time: json['start_time'],
      endTime: json['end_time'],
      subject: json['subject']['name'],
      teacher: json['teacher']['name'],
      classId: json['class']['name'],
      day: json['day'],
      color: Colors.greenAccent,
      isBreak: false,
    );
  }
}
