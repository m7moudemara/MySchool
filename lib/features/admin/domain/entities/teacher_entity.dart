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

  factory TeacherEntity.fromJson(Map<String, dynamic> json) {
    return TeacherEntity(
      id: json['id'].toString(),
      fullName: json['name'] ?? '',
      accountId: json['1359'] ?? '',
      password: json['password'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      nationalId: json['national_id'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      address: json['address'] ?? '',
      isActive: json['is_active'],
      mustChangePassword: json['must_change_password'],
    );
  }
}
