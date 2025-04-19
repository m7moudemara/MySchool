Future<bool> verifyResetCode(String code) async {
  await Future.delayed(Duration(seconds: 2)); // simulate network delay
  return code == "1234"; // simulate correct code
}
