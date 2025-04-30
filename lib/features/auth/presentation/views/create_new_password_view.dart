import 'package:MySchool/core/widgets/custom_snack_bar.dart';
import 'package:MySchool/features/auth/presentation/views/login_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../school/presentation/widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(69)),
          child: Image.asset("assets/congratulation.png"),
        );
      },
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pop(context); // Close dialog
      Navigator.pushReplacementNamed(context, LoginView.id);
    });
  }

  Future<bool> _validateOldPassword(String userId, String oldPassword) async {
    try {
      final dio = Dio();
      final response = await dio.get(
        "https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool/users/$userId",
        options: Options(validateStatus: (status) => status != null && status < 500),
      );

      if (response.statusCode == 200 && response.data != null) {
        final userData = response.data;
        if (userData["password"] == oldPassword) {
          return true;
        } else {
          CustomSnackBar.show(context, "Old password is incorrect", type: SnackBarType.error);
          return false;
        }
      } else {
        CustomSnackBar.show(context, "Failed to validate password. User not found.", type: SnackBarType.error);
        return false;
      }
    } catch (e) {
      CustomSnackBar.show(context, "Error validating password: $e", type: SnackBarType.error);
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
      appBar: isFirstLogin
          ? null
          : AppBar(
              title: const Text(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                if (isFirstLogin)
                  const Text(
                    'Change Password',
                    style: TextStyle(
                      color: Color(0xFF2F496E),
                      fontSize: 24.71,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.12,
                    ),
                  ),
                const SizedBox(height: 20),

                // Old Password
                CustomTextFormField(
                  controller: _oldPasswordController,
                  hintText: "Old Password",
                  obscureText: !_showPassword,
                  validator: (value) =>
                      (value == null || value.isEmpty) ? 'Please enter your old password' : null,
                ),
                const SizedBox(height: 10),

                // New Password
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

                // Confirm Password
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

                // Show password toggle
                Row(
                  children: [
                    Checkbox(
                      value: _showPassword,
                      onChanged: (value) => _togglePasswordVisibility(),
                    ),
                    const Text("Show Password"),
                  ],
                ),
                const SizedBox(height: 20),

                // Submit
                CustomButton(
                  isLoading: isLoading,
                  onTap: () async {
                    if (_formKey.currentState?.validate() != true) return;
                    setState(() => isLoading = true);

                    try {
                      final isValid = await _validateOldPassword(userId, _oldPasswordController.text);
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

                      _showSuccessDialog();
                    } catch (e) {
                      CustomSnackBar.show(context, "Error updating password: $e", type: SnackBarType.error);
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
      ),
    );
  }
}
