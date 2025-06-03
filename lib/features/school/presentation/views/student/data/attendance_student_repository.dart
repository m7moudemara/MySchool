import 'package:MySchool/features/school/presentation/views/student/data/attendance_model.dart';
import 'package:MySchool/features/school/presentation/views/student/data/attendence_student_webservices.dart';

class AttendanceStudentRepository {
  final AttendenceStudentWebservices attendenceStudentWebservices;
  AttendanceStudentRepository({required this.attendenceStudentWebservices});

  Future<List<AttendanceModel>> getAttendance() async {
    print('wwwwwwwwwwwwwwww');
    List<Map<String, dynamic>> responseData =
        await attendenceStudentWebservices.fetchAttendanceData();
    print('ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
    print(responseData[0]['id']);
    print('ooooooooooooooooooooooooooooooooooooooooooooooooooooooooooooo');
    print('rrrrrrrrrrrrrrrrrrrrrrr');
    if (responseData.isEmpty) {
      return [];
    }
    print(
      '78787878787878787878787878787878787878787878787878787878787878787878787',
    );

    print(responseData[0]);
    print(
      '78787878787878787878787878787878787878787878787878787878787878787878787',
    );
    print('wwwwwwwwwwwwwwwwwwwwww');
    print(responseData[0]['id']);
    print('alaaaaaaaaaaaaaaaaaa   ');
    print(responseData[0]['status']);
    return responseData.map((xx) => AttendanceModel.fromJson(xx)).toList();
  }
}
