import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../homework_model.dart';
import '../teacher_home_work_repository.dart';
import '../teacher_home_work_web_services.dart';

part 'teacher_view_homework_state.dart';

class TeacherViewHomeworkCubit extends Cubit<TeacherViewHomeworkState> {
  TeacherViewHomeworkCubit() : super(TeacherViewHomeworkInitial());

    fetchTeacherHomeWorks() async {
    emit(HomeWorksLoading());
    TeacherHomeWorkRepository teacherHomeWorkRepository =
        TeacherHomeWorkRepository(TeacherHomeWorkWebServices());
    try {
      Future.delayed(Duration(seconds: 2));
      List<HomeworkModel> homeWorks =
          await teacherHomeWorkRepository.fetchTeacherHomeWorks();
      emit(HomeWorksLoaded(homeWorks: homeWorks));
    } catch (e) {
      emit(HomeWorksError(message: '$e'));
    }
  }

}
