import 'package:MySchool/features/admin/domain/entities/timetable_entity.dart';
import '../repositories/add_timetable_repository.dart';

class GetTimeTableUseCase {
  final AddTimeTableRepository repo;
  GetTimeTableUseCase(this.repo);
  Future<List<TimeTableEntity>> call() => repo.getAllTimeTables();
}

class AddTimeTableUseCase {
  final AddTimeTableRepository repo;
  AddTimeTableUseCase(this.repo);
  Future<void> call(TimeTableEntity timeTable) => repo.addTimeTable(timeTable);
}

class UpdateTimeTableUseCase {
  final AddTimeTableRepository repo;
  UpdateTimeTableUseCase(this.repo);
  Future<void> call(TimeTableEntity timeTable) => repo.updateTimeTable(timeTable);
}

class DeleteTimeTableUseCase {
  final AddTimeTableRepository repo;
  DeleteTimeTableUseCase(this.repo);
  Future<void> call(String id) => repo.deleteTimeTable(id);
}
