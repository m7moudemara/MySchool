abstract class AuthRepository {
  Future<Map<String, dynamic>> login({
    required String idNumber,
    required String password,
  });


Future<bool> isFirstLogin(String userId);
Future<void> changePassword(String userId, String newPassword);

}








