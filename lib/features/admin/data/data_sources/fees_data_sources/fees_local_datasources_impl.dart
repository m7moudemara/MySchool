import 'package:MySchool/features/admin/data/data_sources/fees_data_sources/fees_local_datasources.dart';
import 'package:MySchool/features/admin/data/models/add_fees_model.dart';

class FeesLocalDataSourceImpl implements FeesLocalDataSource {
  final List<AddFeesModel> _fees = [];

  @override
  Future<List<AddFeesModel>> getAll() async => _fees;

  @override
  Future<void> add(AddFeesModel newFees) async {
    _fees.add(newFees);
  }

  @override
  Future<void> update(AddFeesModel updatedFees) async {
    final index = _fees.indexWhere((c) => c.id == updatedFees.id);
    if (index != -1) {
      _fees[index] = updatedFees;
    }
  }

  @override
  Future<void> delete(String id) async {
    _fees.removeWhere((c) => c.id == id);
  }
}
