// presentation/cubit/parent_cubit.dart


import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_all_parents.dart';

class ParentCubit extends Cubit<List<IUser>> {
  final GetAllParents getAllParents;

  ParentCubit(this.getAllParents) : super([]);

  void loadParents() async {
    final parents = await getAllParents();
    emit(parents);
  }
}
