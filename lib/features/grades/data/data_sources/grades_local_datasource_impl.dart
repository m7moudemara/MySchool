import 'dart:convert';
import 'package:MySchool/constants/strings.dart';
import 'package:MySchool/core/utils/grade_utils.dart';
import 'package:MySchool/features/grades/data/data_sources/grades_local_datasource.dart';
import 'package:MySchool/main.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/sub_entity/subject_grade.dart';
import '../models/student_result_model.dart';

class GradesLocalDatasourceImpl implements GradesLocalDatasource {
  @override
  Future<StudentResultModel?> getGrades(String term, int studentId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final url = Uri.parse(
      '$baseUrl/api/grades?PageSize=500&Where%5Bstudent.id%5D=$studentId',
    );

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
      },
    );
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      List<SubjectGrade> subjects =
          result.map((element) => SubjectGrade.fromJson(element)).toList();
      List<SubjectGrade> firstTermList =
          subjects.where((element) => element.termNumber == 1).toList();
      List<SubjectGrade> secondTermList =
          subjects.where((element) => element.termNumber == 2).toList();
      if (term == 'First Term') {
        return StudentResultModel(
          studentName: result[0]['student']['name'],
          className: result[0]['subject']['name'],
          imageUrl: 'https://example.com/profile.png',
          subjects: firstTermList,
          totalMarks: '${getTotalMarks(firstTermList)['totalMarks']}',
          overallPercentage: '${getTotalMarks(firstTermList)['overall']}',
          overallGrade: '${getTotalMarks(firstTermList)['overAllGrade']}',
        );
      } else if (term == 'Second Term') {
        return StudentResultModel(
          studentName: result[0]['student']['name'],
          className: result[0]['subject']['name'],
          imageUrl: 'https://example.com/profile.png',
          subjects: secondTermList,
          totalMarks: '${getTotalMarks(secondTermList)['totalMarks']}',
          overallPercentage: '${getTotalMarks(secondTermList)['overall']}',
          overallGrade: '${getTotalMarks(secondTermList)['overAllGrade']}',
        );
      }
      return null;
    } else {
      print(jsonDecode(response.body));
      throw Exception('error');
    }

    //   await Future.delayed(const Duration(milliseconds: 500));

    //   if (term == 'First Term') {
    //     return StudentResultModel(
    //       studentName: 'Ahmed Mohamed',
    //       className: 'Grade 10',
    //       imageUrl: 'https://example.com/profile.png',
    //       totalMarks: '480',
    //       overallPercentage: '96%',
    //       overallGrade: 'A+',
    //       subjects: [
    //         SubjectGradeModel(name: 'Math', mark: '95', grade: 'A+'),
    //         SubjectGradeModel(name: 'Science', mark: '90', grade: 'A'),
    //         SubjectGradeModel(name: 'Arabic', mark: '100', grade: 'A+'),
    //         SubjectGradeModel(name: 'English', mark: '95', grade: 'A+'),
    //       ],
    //     );
    //   } else if (term == 'Second Term') {
    //     return StudentResultModel(
    //       studentName: 'Ahmed Mohamed',
    //       className: 'Grade 10',
    //       imageUrl: 'https://example.com/profile.png',
    //       totalMarks: '450',
    //       overallPercentage: '90%',
    //       overallGrade: 'A',
    //       subjects: [
    //         SubjectGradeModel(name: 'Math', mark: '85', grade: 'A'),
    //         SubjectGradeModel(name: 'Science', mark: '88', grade: 'A'),
    //         SubjectGradeModel(name: 'Arabic', mark: '92', grade: 'A+'),
    //         SubjectGradeModel(name: 'English', mark: '85', grade: 'A'),
    //       ],
    //     );
    //   }

    //   return null;
  }

  getTotalMarks(List<SubjectGrade> subjectsx) {
    int totalMarks = 0;
    for (var item in subjectsx) {
      totalMarks += int.tryParse(item.mark) ?? 0;
    }
    double overall = ((totalMarks) / subjectsx.length);

    return {
      'totalMarks': totalMarks,
      'overall': '$overall %',
      'overAllGrade': getGrade(totalMarks, subjectsx.length * 100),
    };
  }
}
