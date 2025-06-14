import 'package:MySchool/features/admin/domain/entities/student_entity.dart';

class AddStudentModel extends StudentEntity {
  const AddStudentModel({
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
    required super.selectedClass,
    required super.myParent,
  });

  factory AddStudentModel.fromEntity(StudentEntity entity) => AddStudentModel(
    id: entity.id,
    fullName: entity.fullName,
    accountId: entity.accountId,
    password: entity.password,
    gender: entity.gender,
    dateOfBirth: entity.dateOfBirth,
    nationalId: entity.nationalId,
    phoneNumber: entity.phoneNumber,
    address: entity.address,
    selectedClass: entity.selectedClass,
    myParent: entity.myParent,
    isActive: entity.isActive,
    mustChangePassword: entity.mustChangePassword,
  );
}
