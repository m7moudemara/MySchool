import 'package:flutter/material.dart';
import 'package:MySchool/widgets/custom_button.dart';
import 'package:MySchool/widgets/custom_text_field.dart';
import 'package:MySchool/constants.dart';
import 'package:MySchool/views/home_student_view.dart';
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

      setState(() => _isLoading = false);

      if (result['success'] == true) {
        
        Navigator.pushReplacementNamed(context, HomeView.id);
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
    Key? key,
    required this.formKey,
    required this.idNumberController,
    required this.passwordController,
    required this.isLoading,
    required this.obscurePassword,
    required this.onPasswordVisibilityToggle,
    required this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: idNumberController,
            hintText: "ID Number",
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ID number';
              }
              return null;
            },
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: passwordController,
            obscureText: obscurePassword,
            decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
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
          const Text("Don't have an account "),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, SignUpView.id);
            },
            child: Text(
              "? Sign up",
              style: TextStyle(color: AppColors.kSecondaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
