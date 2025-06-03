import 'package:MySchool/features/school/presentation/views/teacher/data/class_model.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/classes_repository.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/classes_web_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'classes_state.dart';

class ClassesCubit extends Cubit<ClassesState> {
  ClassesCubit() : super(ClassesInitial());

  void getClasses() async {
    emit(ClassesLoading());
    try {
      ClassesRepository classesRepository = ClassesRepository(
        classesWebServices: ClassesWebServices(),
      );
      Future.delayed(Duration(seconds: 2));
      List<ClassStudentModel> classes = await classesRepository.getClasses();
      emit(ClassesLoaded(classes));
    } catch (e) {
      emit(ClassesLoadedError(message: 'there is an error'));
    }
  }
}
