Future<bool> sendResetCodeToEmail(String email) async {
  await Future.delayed(const Duration(seconds: 2));
  
  return email.contains('@') && email.contains('.com') && email.length > 5;
}
