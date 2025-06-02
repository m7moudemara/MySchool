import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'attendence_state.dart';

class AttendenceCubit extends Cubit<AttendenceState> {
  AttendenceCubit() : super(AttendenceInitial());

  void setPresentNumber(int presentNumber,int absentNumber) {
    emit(AttendencePresentNumberChanged(presentNumber, absentNumber));
  } 
}
