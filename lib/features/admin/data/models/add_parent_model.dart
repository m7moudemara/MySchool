import 'package:MySchool/features/admin/domain/entities/parent_entity.dart';

class AddParentsModel extends ParentEntity {
  const AddParentsModel({
    required super.id,
    required super.fullName,
    required super.accountId,
    required super.password,
    required super.gender,
    required super.dateOfBirth,
    required super.nationalId,
    required super.phoneNumber,
    required super.address,
    required super.isActive,
    required super.mustChangePassword,
  });

  factory AddParentsModel.fromEntity(ParentEntity entity) => AddParentsModel(
    id: entity.id,
    fullName: entity.fullName,
    accountId: entity.accountId,
    password: entity.password,
    gender: entity.gender,
    dateOfBirth: entity.dateOfBirth,
    nationalId: entity.nationalId,
    phoneNumber: entity.phoneNumber,
    address: entity.address,
    isActive: entity.isActive,
    mustChangePassword: entity.mustChangePassword,
  );
}
