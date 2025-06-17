import 'dart:convert';

import 'package:MySchool/core/widgets/custom_snack_bar.dart';
import 'package:MySchool/features/auth/presentation/views/login_view.dart';
import 'package:MySchool/main.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/custom_button.dart';
import 'package:http/http.dart' as http;

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
  late int userId;

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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(69),
          ),
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
                  validator:
                      (value) =>
                          (value == null || value.isEmpty)
                              ? 'Please enter your old password'
                              : null,
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
          
                      String? token = await sharedPrefController.getToken();
                      final url = Uri.parse(
                        '$baseUrl/api/auth/change-password',
                      );
                      final response = await http.put(
                        url,
                        headers: {
                          'Content-Type': 'application/json',
                          'Accept': 'application/json',
                          'Authorization': 'Bearer $token',
                        },
                        body: jsonEncode({
                          "new_password": _newPasswordController.text,
                          "old_password": _oldPasswordController.text,
                        }),
                      );
                      if (response.statusCode == 200) {
                        _showSuccessDialog();
                      } else {
                        print(jsonDecode(response.body));
                        throw Exception(jsonDecode(response.body));
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
      ),
    );
  }
}
