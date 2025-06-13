import 'package:MySchool/features/homework/data/home_work_webservices.dart';
import 'package:MySchool/features/homework/data/homework_model.dart';

class HomeWorkRepository {
  final HomeWorkWebservices homeWorkWebservices;
  HomeWorkRepository(this.homeWorkWebservices);
  // This class will handle the data operations related to homework.
  // It can interact with a database, API, or any other data source.

  // Example method to fetch homework assignments
  Future<List<HomeworkModel>> fetchAssignments() async {
    // Simulate a network call or database query
    List<Map<String, dynamic>> assignments =
        await homeWorkWebservices.fetchHomeworkAssignments();
    List<HomeworkModel> homeworkList =
        assignments
            .map((assignment) => HomeworkModel.fromJson(assignment))
            .toList();
    return homeworkList;
  }

  // Example method to submit homework
  Future<bool> submitAssignment(String assignment) async {
    // Simulate a submission process
    await Future.delayed(Duration(seconds: 1));
    return true; // Assume submission is successful
  }

  Future<List<StudentHomeWorkResult>> getSubmissions(int homeWorkId) async {
    List<Map<String, dynamic>> results = await homeWorkWebservices
        .getSubmissions(homeWorkId);

    return results
        .map((element) => StudentHomeWorkResult.fromJson(element))
        .toList();
  }
}

class StudentHomeWorkResult {
  final int homeWorlId;
  final int assignId;
  final int classId;
  final int subjectId;
  final int studentId;
  final String studentName, filePath, createdAt;

  StudentHomeWorkResult({
    required this.homeWorlId,
    required this.assignId,
    required this.classId,
    required this.subjectId,
    required this.studentId,
    required this.studentName,
    required this.filePath,
    required this.createdAt,
  });

  factory StudentHomeWorkResult.fromJson(Map<String, dynamic> json) {
    return StudentHomeWorkResult(
      homeWorlId: json['id'] ?? 0,
      assignId: json['assignment']['id'] ?? 0,
      classId: json['assignment']['class']['id'] ?? 0,
      subjectId: json['assignment']['subject']['id'] ?? 0,
      studentId: json['student']['id'] ?? 0,
      studentName: json['student']['name'] ?? '',
      filePath: json['file_path'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}
