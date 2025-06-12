import 'package:MySchool/features/admin/data/data_sources/fees_data_sources/fees_local_datasources.dart';
import 'package:MySchool/features/admin/data/models/add_fees_model.dart';
import 'package:MySchool/features/admin/domain/entities/fees_entity.dart';
import 'package:MySchool/features/admin/domain/repositories/fees_repository.dart';


class FeesRepositoryImpl implements FeesRepository {
  final FeesLocalDataSource localDataSource;
  FeesRepositoryImpl(this.localDataSource);

  @override
  Future<void> addFee(FeesEntity newFee) {
    return localDataSource.add(AddFeesModel(
      id: newFee.id,
      dueDate: newFee.dueDate,
      selectSudent: newFee.selectSudent,
      totalAmount: newFee.totalAmount,
      paidAmount: newFee.paidAmount,
    ));
  }

  @override
  Future<void> deleteFee(String id) {
    return localDataSource.delete(id);
  }

  @override
  Future<List<FeesEntity>> getAllFees() {
    return localDataSource.getAll();
  }

  @override
  Future<void> updateFee(FeesEntity updatedFee) {
    return localDataSource.update(AddFeesModel(
      id: updatedFee.id,
      dueDate: updatedFee.dueDate,
      selectSudent: updatedFee.selectSudent,
      totalAmount: updatedFee.totalAmount,
      paidAmount: updatedFee.paidAmount,
    ));
  }
}
