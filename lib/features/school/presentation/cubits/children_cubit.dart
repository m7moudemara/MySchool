import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:MySchool/features/school/domain/usecases/get_children.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildrenCubit extends Cubit<List<Student>> {
  final GetChildrenUseCase useCase;

  ChildrenCubit(this.useCase) : super([]);

  void fetchChildren(String parentId) async {
    try {
      final children = await useCase.execute(parentId: parentId);
      emit(children);
    } catch (e) {
      emit([]); 
    }
  }
}
