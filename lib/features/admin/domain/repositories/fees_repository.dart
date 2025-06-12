import 'package:MySchool/features/admin/domain/entities/fees_entity.dart';

abstract class FeesRepository {
  Future<List<FeesEntity>> getAllFees();
  Future<void> addFee(FeesEntity feesEntity);
  Future<void> updateFee(FeesEntity feesEntity);
  Future<void> deleteFee(String id);
}
