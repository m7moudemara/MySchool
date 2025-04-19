abstract class AuthRepository {
  Future<Map<String, dynamic>> login({
    required String idNumber,
    required String password,
  });
// TODO: Implement real email sending logic once backend is ready
//   Future<void> sendResetCode(String email);
}



