import 'package:MySchool/features/school/domain/entities/user_type.dart';



abstract class UserRepository {
  Future<List<IUser>> getAllParents();
  Future<List<IUser>> getAllTeachers();
  Future<List<IUser>> getAllStudents();
}
