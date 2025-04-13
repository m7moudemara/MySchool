import 'package:MySchool/views/sign_up/login_view.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class CreateNewPasswordView extends StatefulWidget {
  const CreateNewPasswordView({super.key});
  static String id = '/CreateNewPasswordView';

  @override
  _CreateNewPasswordViewState createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreateNewPasswordView> {
  bool _showPassword = false;
  bool _showConfirmationDialog = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _showSuccessDialog() {
    setState(() {
      _showConfirmationDialog = true;
    });

    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacementNamed(context, LoginView.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Create New Password"),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    "Create New Password",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Your new password must be different from your previous password",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    hintText: "New Password",
                    obscureText: !_showPassword,
                  ),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                    hintText: "Confirm New Password",
                    obscureText: !_showPassword,
                  ),
                  const SizedBox(height: 10),
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
                  CustomButton(
                    onTap: () {
                      // Simulate password reset logic
                      _showSuccessDialog();
                    },
                    text: "Reset Password",
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            if (_showConfirmationDialog)
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(69),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/congratulation.png",
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Congratulations!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Password Reset successful.\nYou’ll be redirected to the login screen now.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}