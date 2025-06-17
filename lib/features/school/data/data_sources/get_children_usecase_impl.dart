// import 'package:MySchool/features/school/data/models/student_model.dart';
// import 'package:MySchool/features/school/domain/usecases/get_children.dart';
// import 'dio_service.dart';

// class GetChildrenUseCaseImpl implements GetChildrenUseCase {
//   // final DioService dioService;

//   GetChildrenUseCaseImpl(this.dioService);

//   @override
//   Future<List<Student>> execute({required String parentId}) async {
//     final users = await dioService.fetchAllUsers();

//     final students = users
//         .where((user) =>
//             user['role'] == 'student' && user['parentId'] == parentId)
//         .map((studentJson) => Student.fromJson(studentJson))
//         .toList();

//     return students;
//   }
// }
