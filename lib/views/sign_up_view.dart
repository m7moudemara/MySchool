import 'package:flutter/material.dart';
import 'package:MySchool/widgets/custom_button.dart';
import 'package:MySchool/widgets/custom_text_field.dart';
import 'package:MySchool/constants.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static String id = "/SignUpView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const SignUpImage(),
                const SizedBox(height: 20),
                const HelloText(),
                const SizedBox(height: 20),
                SignUpForm(),

                const HaveAnAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignUpImage extends StatelessWidget {
  const SignUpImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage("assets/signup_image.png"),
      height: 121,
    );
  }
}

class HelloText extends StatelessWidget {
  const HelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        AppTexts.helloText,
        style: TextStyle(color: AppColors.kPrimaryColor, fontSize: 16),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "Name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: "Email",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: "ID Number",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your ID number';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            hintText: "Password",
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          CustomButton(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // Process data
              }
            },
            text: "Sign Up",
          ),
        ],
      ),
    );
  }
}

class HaveAnAccountText extends StatelessWidget {
  const HaveAnAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(AppTexts.haveAccountText),

          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/LoginView');
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50, 30),
            ),
            child: Text(
              AppTexts.loginText,
              style: TextStyle(color: AppColors.kSecondaryColor, fontSize: 13.33),
            ),
          ),
        ],
      ),
    );
  }
}
