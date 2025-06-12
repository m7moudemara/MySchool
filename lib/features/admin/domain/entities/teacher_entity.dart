class TeacherEntity {
  final String id;
  final String fullName;
  final String accountId;
  final String password;
  final String gender;
  final String dateOfBirth;
  final String nationalId;
  final String phoneNumber;
  final String address;
  final bool isActive;
  final bool mustChangePassword;

  const TeacherEntity({
    required this.id,
    required this.fullName,
    required this.accountId,
    required this.password,
    required this.gender,
    required this.dateOfBirth,
    required this.nationalId,
    required this.phoneNumber,
    required this.address,
    required this.isActive,
    required this.mustChangePassword,
  });
}
