import 'dart:async';

import 'package:MySchool/features/auth/domain/repositories/reset_password_repository.dart';


class MockResetPasswordRepository implements ResetPasswordRepository {
  @override
  Future<void> resetPassword({required String newPassword}) async {
    await Future.delayed(const Duration(seconds: 2)); // simulate network delay

    // simulate success response
    if (newPassword == "error") {
      throw Exception("Password reset failed.");
    }
  }
}
