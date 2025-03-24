import 'package:MySchool/views/forget_password_view.dart';
import 'package:MySchool/views/home_view.dart';
import 'package:MySchool/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/widgets/custom_button.dart';
import 'package:MySchool/widgets/custom_text_field.dart';
import 'package:MySchool/constants.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  static String id = '/LoginView';

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
                const LoginForm(),
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
      style: TextStyle(color: AppColors.kSecondaryColor,fontSize: 16)
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _idNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  final _idNumberFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _idNumberController.dispose();
    _passwordController.dispose();
    _idNumberFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Logging in...'),
          duration: Duration(seconds: 2),
        ),
      );

      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, HomeView.id);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _idNumberController,
            focusNode: _idNumberFocusNode,
            hintText: "ID Number",
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ID number';
              }
              return null;
            },
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_passwordFocusNode);
            },
          ),
          const SizedBox(height: 15),
          CustomTextField(
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            hintText: "Password",
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
            onFieldSubmitted: (_) {
              _submitForm();
            },
          ),
          
          const ForgotPasswordText(),
          CustomButton(
            onTap: _submitForm,
            text: "Login",
          ),
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
      padding: const EdgeInsets.symmetric(vertical: 3.0,horizontal: 6),
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
      padding: const EdgeInsets.symmetric(vertical: 5.0,horizontal: 6),
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