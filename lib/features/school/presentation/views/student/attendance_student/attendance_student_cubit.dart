import 'package:MySchool/features/school/presentation/views/student/data/attendance_model.dart';
import 'package:MySchool/features/school/presentation/views/student/data/attendance_student_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/attendence_student_webservices.dart';

part 'attendance_student_state.dart';

class AttendanceStudentCubit extends Cubit<AttendanceStudentState> {
  AttendanceStudentCubit() : super(AttendanceStudentInitial());

  fetchAttendanceData() async {
    // print('asdffffffffffffffffffffffffffff');
    emit(AttendanceStudentLoading());
    try {
      // print('55555555555555555');
      // Replace 'yourArgument' with the actual required argument for the repository constructor
      AttendanceStudentRepository repository = AttendanceStudentRepository(
        attendenceStudentWebservices: AttendenceStudentWebservices(),
      );
      // print('6666666666666666');
      List<AttendanceModel> attendances = await repository.getAttendance();
      // print('bbbbbbbbbbbbbbbbbbbbbb');
      // print(attendances);
      // print('qqqqqqqqqqqqqqqq   ');
      // Simulate fetching data from a repository or API
      await Future.delayed(Duration(seconds: 2));
      // List<AttendanceModel> attendances = [
      //   AttendanceModel(date: '2023-10-01', status: 'Present'),
      //   AttendanceModel(date: '2023-10-02', status: 'Absent'),
      //   // Add more mock data as needed
      // ];
      emit(AttendanceStudentLoaded(attendances));
    } catch (e) {
      emit(AttendanceStudentError('Failed to fetch attendance data'));
    }
  }

  void setAttendanceData(List<AttendanceModel> attendances) {
    // This method can be used to set attendance data if needed
    emit(AttendanceStudentLoaded(attendances));
  }
}
