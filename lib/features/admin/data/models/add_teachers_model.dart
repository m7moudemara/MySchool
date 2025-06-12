// data/models/teachers.dart
import 'package:MySchool/features/admin/domain/entities/teacher_entity.dart';

class AddTeachersModel extends TeacherEntity {
  const AddTeachersModel({
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

  factory AddTeachersModel.fromEntity(TeacherEntity entity) => AddTeachersModel(
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
