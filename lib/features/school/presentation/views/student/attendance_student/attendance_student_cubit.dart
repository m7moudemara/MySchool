import 'package:MySchool/features/school/presentation/views/student/data/attendance_model.dart';
import 'package:MySchool/features/school/presentation/views/student/data/attendance_student_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/attendence_student_webservices.dart';

part 'attendance_student_state.dart';

class AttendanceStudentCubit extends Cubit<AttendanceStudentState> {
  AttendanceStudentCubit() : super(AttendanceStudentInitial());

  fetchAttendanceData() async {
    emit(AttendanceStudentLoading());
    try {
      AttendanceStudentRepository repository = AttendanceStudentRepository(
        attendenceStudentWebservices: AttendenceStudentWebservices(),
      );

      List<AttendanceModel> attendances = await repository.getAttendance();
 
      await Future.delayed(Duration(seconds: 2));
 
      // ];
      emit(AttendanceStudentLoaded(attendances));
    } catch (e) {
      emit(AttendanceStudentError('Failed to fetch attendance data'));
    }
  }

  void setAttendanceData(List<AttendanceModel> attendances) {
    emit(AttendanceStudentLoaded(attendances));
  }
}
