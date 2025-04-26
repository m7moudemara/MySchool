import 'package:MySchool/core/app_session.dart';
import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/widgets/custom_snack_bar.dart';
import 'package:MySchool/features/auth/data/repositories/mock_reset_password_repository.dart';
import 'package:MySchool/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:MySchool/features/auth/presentation/views/login_view.dart';
import 'package:MySchool/features/main_wrapper/domain/entities/user_role.dart';
import 'package:MySchool/features/main_wrapper/presentation/views/main_wrapper_view.dart';
import 'package:MySchool/features/school/data/models/student_model.dart';
import 'package:MySchool/features/school/data/models/teacher_model.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../../../school/presentation/widgets/custom_text_field.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});
  static String id = '/CreateNewPasswordView';

  @override
  _CreateNewPasswordViewState createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  late String userId;

  bool isFirstLogin = false;
  bool _showPassword = false;
  bool isLoading = false;
  bool _showConfirmationDialog = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && args is Map<String, dynamic>) {
      userId = args['userId'] ?? '';
      isFirstLogin = args['is_first_login'] ?? false;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _showSuccessDialog() {
    setState(() {
      _showConfirmationDialog = true;
    });

  Future.delayed(const Duration(seconds: 3), () {
    if (isFirstLogin) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginView.id,
        (route) => false,
      );
    } else {
      Navigator.pushReplacementNamed(context, LoginView.id);
    }
  });
  }

  Future<bool> _validateOldPassword(String userId, String oldPassword) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool/users/$userId",
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final userData = response.data;
        if (userData["password"] == oldPassword) {
          return true;
        } else {
          CustomSnackBar.show(
            context,
            "Old password is incorrect",
            type: SnackBarType.error,
          );
          return false;
        }
      } else {
        CustomSnackBar.show(
          context,
          "Failed to validate password. User not found.",
          type: SnackBarType.error,
        );

        return false;
      }
    } catch (e) {
      CustomSnackBar.show(
        context,
        "Error validating password: $e",
        type: SnackBarType.error,
      );
      return false;
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          isFirstLogin
              ? null
              : AppBar(
                title: Text(
                  'Change Password',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.14,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.white,
              ),
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    isFirstLogin
                        ? Text(
                          'Change Password',
                          style: TextStyle(
                            color: const Color(0xFF2F496E),
                            fontSize: 24.71,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.12,
                          ),
                        )
                        : const SizedBox(),

                    const SizedBox(height: 20),

                    // Old Password Field
                    CustomTextFormField(
                      controller: _oldPasswordController,
                      hintText: "Old Password",
                      obscureText: !_showPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your old password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // New Password Field
                    CustomTextFormField(
                      controller: _newPasswordController,
                      hintText: "New Password",
                      obscureText: !_showPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your new password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    // Confirm New Password
                    CustomTextFormField(
                      controller: _confirmPasswordController,
                      hintText: "Confirm New Password",
                      obscureText: !_showPassword,
                      validator: (value) {
                        if (value != _newPasswordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),

                    //  Show Password
                    Row(
                      children: [
                        Checkbox(
                          value: _showPassword,
                          onChanged: (value) {
                            _togglePasswordVisibility();
                          },
                        ),
                        const Text("Show Password"),
                      ],
                    ),
                    const SizedBox(height: 20),

                    //  Submit Button
                    CustomButton(
                      isLoading: isLoading,
                      onTap: () async {
                        if (_formKey.currentState?.validate() != true) return;
                        setState(() => isLoading = true);

                        try {
                          final isValid = await _validateOldPassword(
                            userId,
                            _oldPasswordController.text,
                          );

                          if (!isValid) {
                            setState(() => isLoading = false);
                            return;
                          }

                          final dio = Dio();

                          await dio.put(
                            "https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool/users/$userId",
                            data: {
                              "password": _newPasswordController.text,
                              "is_first_login": false,
                            },
                          );
                          if (isFirstLogin) {
                            final user = AppSession.currentUser;
                            if (user != null) {
                              UserType userType;

                              if (user is Student) {
                                userType = UserType.student;
                              } else if (user is Teacher) {
                                userType = UserType.teacher;
                              } else {
                                userType = UserType.parent;
                              }
                                _showSuccessDialog();
                            } 
                          }
                          
                          else {
                           _showSuccessDialog();
                          }
                        } catch (e) {
                          CustomSnackBar.show(
                            context,
                            "Error updating password: $e",
                            type: SnackBarType.error,
                          );
                        } finally {
                          setState(() => isLoading = false);
                        }
                      },

                      text: isFirstLogin ? "Verify" : "Change Password",
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            //  Dialog
            if (_showConfirmationDialog)
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Image.asset("assets/congratulation.png"),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
