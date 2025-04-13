import 'package:MySchool/core/app_session.dart';
import 'package:MySchool/models/student.dart';
import 'package:MySchool/routes/app_routes.dart';
import 'package:MySchool/views/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/widgets/custom_button.dart';
import 'package:MySchool/widgets/custom_text_field.dart';
import 'package:MySchool/constants.dart';

import 'package:MySchool/views/sign_up/forget_password_view.dart';
import 'package:MySchool/views/sign_up/sign_up_view.dart';
import 'package:MySchool/services/auth_service.dart'; 
class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static String id = '/LoginView';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _idNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _obscurePassword = true; 

  @override
  void dispose() {
    _idNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final result = await _authService.login(
        idNumber: _idNumberController.text.trim(),
        password: _passwordController.text.trim(),
      );

      setState(() => _isLoading = false
      );

      if (result['success']) {
        final userJson = result['user'];
        final role = parseUserRole(userJson['role']);
       late IUser user;

if (role == UserRole.student) {
  user = Student.fromJson(userJson);
} else if (role == UserRole.teacher) {
  user = Teacher.fromJson(userJson);
} else {
  user = Parent.fromJson(userJson);
}



        AppSession.currentUser = user; 
        print("Saved user in AppSession: ${AppSession.currentUser.runtimeType}");
        print("userJson: $userJson");
print("role from JSON: ${userJson['role']}");

     Navigator.pushReplacementNamed(
    context,
    MainWrapper.id,
    arguments: RouteArguments(role: role),
  );
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['error']),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 20),
                const LoginImage(),
                const SizedBox(height: 20),
                const HelloText(),
                const SizedBox(height: 20),
                LoginForm(
                  formKey: _formKey,
                  idNumberController: _idNumberController,
                  passwordController: _passwordController,
                  isLoading: _isLoading,
                  obscurePassword: _obscurePassword,
                  onPasswordVisibilityToggle: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  onSubmit: _submitForm,
                ),
                const SignUpText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage("assets/login_image.png"),
      height: 238,
      width: 238,
    );
  }
}

class HelloText extends StatelessWidget {
  const HelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Hello, Login to continue using our app",
      style: TextStyle(color: AppColors.kSecondaryColor, fontSize: 16),
    );
  }
}

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
                    obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined ,
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
          const ForgotPasswordText(),
          isLoading
              ? const CircularProgressIndicator()
              : CustomButton(onTap: onSubmit, text: "Login"),
        ],
      ),
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 6),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, ForgetPasswordView.id);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Forgot Password?",
              style: TextStyle(color: AppColors.kSecondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text("Don't have an account? "),
          InkWell(
            onTap: () {
              //!Deleted Code
              // Navigator.pushReplacementNamed(context, SignUpView.id);
            },
            child: Text(
              "Sign up",
              style: TextStyle(color: AppColors.kSecondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
