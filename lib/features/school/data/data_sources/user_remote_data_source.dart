import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:MySchool/features/school/data/models/teacher_model.dart';


import '../models/parent_model.dart';

abstract class UserRemoteDataSource {
  Future<List<Parent>> fetchAllParents();
  Future<List<Teacher>> fetchAllTeachers();
  Future<List<Student>> fetchAllStudents();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<List<Parent>> fetchAllParents() async {
    await Future.delayed(Duration(milliseconds: 500));
    return [];
  }
  
  @override
  Future<List<Student>> fetchAllStudents() {
    throw UnimplementedError();
  }
  
  @override
  Future<List<Teacher>> fetchAllTeachers() {
    throw UnimplementedError();
  }
}
