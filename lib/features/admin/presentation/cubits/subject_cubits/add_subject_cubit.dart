import 'package:MySchool/features/admin/domain/entities/subject_entity.dart';
import 'package:MySchool/features/admin/domain/usecases/add_subject_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSubjectState {
  final List<SubjectEntity> subject;
  final bool isLoading;

  AddSubjectState({required this.subject, this.isLoading = false});
}

class AddSubjectCubit extends Cubit<AddSubjectState> {
  final GetSubjectUseCase getAll;
  final AddSubjectUseCase add;
  final UpdateSubjectUseCase update;
  final DeleteSubjectUseCase delete;

  AddSubjectCubit({
    required this.getAll,
    required this.add,
    required this.update,
    required this.delete,
  }) : super(AddSubjectState(subject: []));

  void loadSubjects() async {
    emit(AddSubjectState(subject: [], isLoading: true));
    final result = await getAll();
    emit(AddSubjectState(subject: result));
  }

  void addSubject(SubjectEntity entity) async {
    await add(entity);
    loadSubjects();
  }

  void updateSubject(SubjectEntity entity) async {
    await update(entity);
    loadSubjects();
  }

  void deleteSubject(String id) async {
    await delete(id);
    loadSubjects();
  }
}
