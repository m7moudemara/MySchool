import 'package:MySchool/features/homework/data/home_work_repository.dart';
import 'package:MySchool/features/homework/data/home_work_webservices.dart';
import 'package:MySchool/features/homework/data/homework_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_work_state.dart';

class HomeWorkCubit extends Cubit<HomeWorkState> {
  HomeWorkCubit() : super(HomeWorkInitial());

  void loadHomeWorks() {
    emit(HomeWorkLoading());
    try {
      HomeWorkRepository homeWorkRepository = HomeWorkRepository(
        homeWorkWebservices: HomeWorkWebservices(),
      );
      // Simulate a delay for loading
      Future.delayed(Duration(seconds: 1), () async {
        List<HomeworkModel> homeWorks =
            await homeWorkRepository.fetchAssignments();
        // print(homeWorks);
        emit(HomeWorkLoaded(homeWorks));
      });
    } catch (e) {
      emit(HomeWorkError("Failed to load homework assignments"));
    }
  }
}
