import 'package:MySchool/features/auth/presentation/widgets/custom_button.dart';
import 'package:MySchool/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController idNumberController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool obscurePassword;
  final VoidCallback onPasswordVisibilityToggle;
  final Future<void> Function() onSubmit;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.idNumberController,
    required this.passwordController,
    required this.isLoading,
    required this.obscurePassword,
    required this.onPasswordVisibilityToggle,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          //! ID Number
          CustomTextFormField(
            controller: idNumberController,
            hintText: "ID Number",
            // keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ID number';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          //! Password
          CustomTextFormField(
            hintText: "Password",
            controller: passwordController,
            obscureText: obscurePassword,

            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: IconButton(
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
                onPressed: onPasswordVisibilityToggle,
              ),
            ),

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          CustomButton(onTap: onSubmit, text: "Login", isLoading: isLoading),
        ],
      ),
    );
  }
}
