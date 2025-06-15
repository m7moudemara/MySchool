import 'package:MySchool/features/school/presentation/views/student/data/attendance_model.dart';
import 'package:MySchool/features/school/presentation/views/student/data/attendence_student_webservices.dart';

class AttendanceStudentRepository {
  final AttendenceStudentWebservices attendenceStudentWebservices;
  AttendanceStudentRepository({required this.attendenceStudentWebservices});

  Future<List<AttendanceModel>> getAttendance() async {
    List<Map<String, dynamic>> responseData =
        await attendenceStudentWebservices.fetchAttendanceData();
    if (responseData.isEmpty) {
      return [];
    }
    return responseData.map((xx) => AttendanceModel.fromJson(xx)).toList();
  }
}
