import 'package:MySchool/features/admin/domain/entities/class_entity.dart';
import 'package:MySchool/features/admin/domain/entities/fees_entity.dart';
import 'package:MySchool/features/admin/domain/usecases/add_fess_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddFeesState {
  final List<FeesEntity> fees;
  final bool isLoading;

  AddFeesState({required this.fees, this.isLoading = false});
}

class AddFeesCubit extends Cubit<AddFeesState> {
  final GetFeesUseCase getAll;
  final AddFeesUseCase add;
  final UpdateFeesUseCase update;
  final DeleteFeesUseCase delete;

  AddFeesCubit({
    required this.getAll,
    required this.add,
    required this.update,
    required this.delete,
  }) : super(AddFeesState(fees: []));

  void loadFees() async {
    emit(AddFeesState(fees: [], isLoading: true));
    final result = await getAll();
    emit(AddFeesState(fees: result));
  }

  void addFees(FeesEntity entity) async {
    await add(entity);
    loadFees();
  }

  void updateFees(FeesEntity entity) async {
    await update(entity);
    loadFees();
  }

  void deleteFees(String id) async {
    await delete(id);
    loadFees();
  }
}
