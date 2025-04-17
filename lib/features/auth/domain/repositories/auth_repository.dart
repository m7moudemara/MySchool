abstract class AuthRepository {
  Future<Map<String, dynamic>> login({
    required String idNumber,
    required String password,
  });
}
