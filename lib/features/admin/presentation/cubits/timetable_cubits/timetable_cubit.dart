import 'package:MySchool/features/admin/domain/usecases/add_timetable_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/features/admin/domain/entities/timetable_entity.dart';

class AddTimeTableState {
  final List<TimeTableEntity> timeTables;
  final bool isLoading;
  const AddTimeTableState({required this.timeTables, this.isLoading = false});
}

class AddTimeTableCubit extends Cubit<AddTimeTableState> {
  final GetTimeTableUseCase getAll;
  final AddTimeTableUseCase add;
  final UpdateTimeTableUseCase update;
  final DeleteTimeTableUseCase delete;

  AddTimeTableCubit({
    required this.getAll,
    required this.add,
    required this.update,
    required this.delete,
  }) : super(const AddTimeTableState(timeTables: []));

  Future<void> loadTimeTables() async {
    emit(const AddTimeTableState(timeTables: [], isLoading: true));
    final list = await getAll();
    emit(AddTimeTableState(timeTables: list));
  }

  Future<void> addTimeTable(TimeTableEntity timeTable) async {
    await add(timeTable);
    await loadTimeTables();
  }

  Future<void> updateTimeTable(TimeTableEntity timeTable) async {
    await update(timeTable);
    await loadTimeTables();
  }

  Future<void> deleteTimeTable(String id) async {
    await delete(id);
    await loadTimeTables();
  }
}
