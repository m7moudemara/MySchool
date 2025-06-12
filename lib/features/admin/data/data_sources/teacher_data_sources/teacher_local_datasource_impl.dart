// import 'package:MySchool/features/admin/data/models/add_teachers_model.dart';
// import 'teacher_local_datasource.dart';

// class TeacherLocalDataSourceImpl implements TeacherLocalDataSource {
//   final List<AddTeachersModel> _teachers = [];

// @override
// Future<List<AddTeachersModel>> getAll() async => List.from(_teachers);


//   @override
//   Future<void> add(AddTeachersModel newTeacher) async {
//     _teachers.add(newTeacher);
//   }

//   @override
//   Future<void> update(AddTeachersModel updatedTeacher) async {
//     final index = _teachers.indexWhere((c) => c.id == updatedTeacher.id);
//     if (index != -1) {
//       _teachers[index] = updatedTeacher;
//     }
//   }

//   @override
//   Future<void> delete(String id) async {
//     _teachers.removeWhere((c) => c.id == id);
//   }
// }
