import 'package:MySchool/features/grades/data/data_sources/grades_local_datasource.dart';
import 'package:MySchool/features/grades/data/models/sub_model/subject_model.dart';

import '../models/student_result_model.dart';

class GradesLocalDatasourceImpl implements GradesLocalDatasource {
  @override
  Future<StudentResultModel?> getGrades(String term) async {
    await Future.delayed(const Duration(milliseconds: 500)); 

    if (term == 'First Term') {
      return StudentResultModel(
        studentName: 'Ahmed Mohamed',
        className: 'Grade 10',
        imageUrl: 'https://example.com/profile.png',
        totalMarks: '480',
        overallPercentage: '96%',
        overallGrade: 'A+',
        subjects: [
          SubjectGradeModel(name: 'Math', mark: '95', grade: 'A+'),
          SubjectGradeModel(name: 'Science', mark: '90', grade: 'A'),
          SubjectGradeModel(name: 'Arabic', mark: '100', grade: 'A+'),
          SubjectGradeModel(name: 'English', mark: '95', grade: 'A+'),
        ],
      );
    } else if (term == 'Second Term') {
      return StudentResultModel(
        studentName: 'Ahmed Mohamed',
        className: 'Grade 10',
        imageUrl: 'https://example.com/profile.png',
        totalMarks: '450',
        overallPercentage: '90%',
        overallGrade: 'A',
        subjects: [
          SubjectGradeModel(name: 'Math', mark: '85', grade: 'A'),
          SubjectGradeModel(name: 'Science', mark: '88', grade: 'A'),
          SubjectGradeModel(name: 'Arabic', mark: '92', grade: 'A+'),
          SubjectGradeModel(name: 'English', mark: '85', grade: 'A'),
        ],
      );
    }

    return null; 
  }
}
