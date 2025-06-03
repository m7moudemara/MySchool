// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:MySchool/features/time_table/data/datasources/lessons_web_services.dart';
import 'package:MySchool/features/time_table/domain/entities/lesson_entity.dart';

class LessonsRepository {
  final LessonsWebServices lessonsWebServices;
  LessonsRepository(this.lessonsWebServices);

  Future<List<LessonEntity>> getLessons() async {
    List xx = await lessonsWebServices.getLessons();
    List<LessonEntity> lessons =
        xx.map((element) => LessonEntity.fromJson(element)).toList();
    return lessons;
  }
}
