
import 'package:MySchool/features/admin/domain/entities/fees_entity.dart';

import 'package:MySchool/features/admin/domain/repositories/fees_repository.dart';

class GetFeesUseCase {
  final FeesRepository repository;
  GetFeesUseCase(this.repository);
  Future<List<FeesEntity>> call() => repository.getAllFees();
}

class AddFeesUseCase {
  final FeesRepository repository;
  AddFeesUseCase(this.repository);
  Future<void> call(FeesEntity newFees) => repository.addFee(newFees);
}

class UpdateFeesUseCase {
  final FeesRepository repository;
  UpdateFeesUseCase(this.repository);
  Future<void> call(FeesEntity updatedFees) => repository.updateFee(updatedFees);
}

class DeleteFeesUseCase {
  final FeesRepository repository;
  DeleteFeesUseCase(this.repository);
  Future<void> call(String id) => repository.deleteFee(id);
}
