import 'package:MySchool/features/homework/data/home_work_webservices.dart';
import 'package:MySchool/features/homework/data/homework_model.dart';

class HomeWorkRepository {
  final HomeWorkWebservices homeWorkWebservices;
  HomeWorkRepository({required this.homeWorkWebservices});
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
    // print(homeworkList);
    // print('ffffffffffffffffffffffffffffffffffffffffffffffffffff');
    return homeworkList;
    // print(
    //   assignments
    //       .map((assignment) => HomeworkModel.fromJson(assignment))
    //       .toList(),
    // );
    // return assignments
    //     .map((assignment) => HomeworkModel.fromJson(assignment))
    //     .toList();
  }

  // Example method to submit homework
  Future<bool> submitAssignment(String assignment) async {
    // Simulate a submission process
    await Future.delayed(Duration(seconds: 1));
    return true; // Assume submission is successful
  }
}
