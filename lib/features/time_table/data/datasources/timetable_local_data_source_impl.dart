// import 'dart:ui';

// import 'package:MySchool/features/time_table/data/datasources/timetable_local_data_source.dart';
// import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';

// class TimeTableLocalDataSourceImpl implements TimeTableLocalDataSource {
//   final Map<String, List<LessonEntity>> localLessons = {
//     for (final day in [
//       "Saturday",
//       "Sunday",
//       "Monday",
//       "Tuesday",
//       "Wednesday",
//       "Thursday",
//     ])
//       day: [
//         LessonEntity(
//           time: '09:00 AM',
//           endTime: '09:50 AM',
//           subject: 'Mathematics',
//           teacher: 'by Hana Mohamed',
//           color: Color(0xffE8DBFC),
//           isBreak: false,
//           classId: 'A',
//         ),
//         LessonEntity(
//           time: '09:50 AM',
//           endTime: '10:00 AM',
//           subject: 'Mathematics',
//           teacher: 'by Hana Mohamed',
//           color: Color(0xffFFF3CB),
//           isBreak: false,
//           classId: 'B',
//         ),
//         LessonEntity(
//           time: '10:00 AM',
//           endTime: '10:50 AM',
//           subject: 'Morning Break',
//           teacher: '',
//           color: Color(0xffC0EED5),
//           isBreak: true,
//           classId: 'C',
//         ),
//         LessonEntity(
//           time: '10:50 AM',
//           endTime: '11:00 AM',
//           subject: 'Mathematics',
//           teacher: 'by Hana Mohamed',
//           color: Color(0xffE8DBFC),
//           isBreak: false,
//           classId: 'D',
//         ),
//         LessonEntity(
//           time: '11:00 AM',
//           endTime: '11:50 AM',
//           subject: 'Mathematics',
//           teacher: 'by Hana Mohamed',
//           color: Color(0xffCBA8A0),
//           isBreak: false,
//           classId: 'A',
//         ),
//         LessonEntity(
//           time: '11:50 AM',
//           endTime: '12:00 PM',
//           subject: 'Afternoon Break',
//           teacher: '',
//           color: Color(0xffC0EED5),
//           isBreak: true,
//           classId: 'B',
//         ),
//         LessonEntity(
//           time: '01:05 AM',
//           endTime: '01:55 PM',
//           subject: 'Mathematics',
//           teacher: 'by Hana Mohamed',
//           color: Color(0xffFED1B5),
//           isBreak: false,
//           classId: 'C',
//         ),
//       ],
//     "Friday": [],
//   };

//   @override
//   List<LessonEntity> getLessonsForDay(String day) {
//     return localLessons[day] ?? [];
//   }
// }

import 'dart:ui';

import 'package:MySchool/features/time_table/data/datasources/timetable_local_data_source.dart';
import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';

import 'lessons_repository.dart';
import 'lessons_web_services.dart';

class TimeTableLocalDataSourceImpl implements TimeTableLocalDataSource {
  final Map<String, List<LessonEntity>> localLessons = {
    for (final day in [
      "Saturday",
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
    ])
      day: [
        LessonEntity(
          time: '09:00 AM',
          endTime: '09:50 AM',
          subject: 'Mathematics',
          teacher: 'by Hana Mohamed',
          color: Color(0xffE8DBFC),
          isBreak: false,
          classId: 'A', day: 4,
        ),
        LessonEntity(
          time: '09:50 AM',
          endTime: '10:00 AM',
          subject: 'Mathematics',
          teacher: 'by Hana Mohamed',
          color: Color(0xffFFF3CB),
          isBreak: false,
          classId: 'B',day: 4,
        ),
        LessonEntity(
          time: '10:00 AM',
          endTime: '10:50 AM',
          subject: 'Morning Break',
          teacher: '',
          color: Color(0xffC0EED5),
          isBreak: true,
          classId: 'C',day: 4,
        ),
        LessonEntity(
          time: '10:50 AM',
          endTime: '11:00 AM',
          subject: 'Mathematics',
          teacher: 'by Hana Mohamed',
          color: Color(0xffE8DBFC),
          isBreak: false,
          classId: 'D',day: 4,
        ),
        LessonEntity(
          time: '11:00 AM',
          endTime: '11:50 AM',
          subject: 'Mathematics',
          teacher: 'by Hana Mohamed',
          color: Color(0xffCBA8A0),
          isBreak: false,
          classId: 'A',day: 4,
        ),
        LessonEntity(
          time: '11:50 AM',
          endTime: '12:00 PM',
          subject: 'Afternoon Break',
          teacher: '',
          color: Color(0xffC0EED5),
          isBreak: true,
          classId: 'B',day: 4,
        ),
        LessonEntity(
          time: '01:05 AM',
          endTime: '01:55 PM',
          subject: 'Mathematics',
          teacher: 'by Hana Mohamed',
          color: Color(0xffFED1B5),
          isBreak: false,
          classId: 'C',day: 4,
        ),
      ],
    "Friday": [],
  };

  @override
  List<LessonEntity> getLessonsForDay(String day) {
    return localLessons[day] ?? [];
  }
}
