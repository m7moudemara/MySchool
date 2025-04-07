import 'package:MySchool/views/sign_up/reset_password_view.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});
  static String id = '/ForgetPasswordView';

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
                const ForgetPasswordText(),
                const SizedBox(height: 20),
                const ForgetPasswordImage(),
                const SizedBox(height: 20),
                const EnterEmailText(),
                const SizedBox(height: 10),
                const EmailAddressText(),
                const SizedBox(height: 10),
                ForgetPasswordForm(),
                const SizedBox(height: 20),
                const RememberText(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgetPasswordForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "Email address",
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email address';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomButton(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Processing your request...'),
                    duration: Duration(seconds: 2),
                  ),
                );

                // Simulate a network call or other async operation
                Future.delayed(const Duration(seconds: 2), () {
                  Navigator.pushNamed(context, ResetPasswordView.id); // تم التعديل هنا
                });
              }
            },
            text: "Next",
          ),
        ],
      ),
    );
  }
}

class ForgetPasswordImage extends StatelessWidget {
  const ForgetPasswordImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage("assets/forget_password_image.png"),
      width: 267,
      height: 267,
    );
  }
}

class RememberText extends StatelessWidget {
  const RememberText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Remember the password? "),
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/SignUpView');
            },
            child: const Text(
              "Sign in",
              style: TextStyle(color: Color(0xff3620C2)),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailAddressText extends StatelessWidget {
  const EmailAddressText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Email address",
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class EnterEmailText extends StatelessWidget {
  const EnterEmailText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "Enter your registered email below",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Forgot Password ?",
      style: TextStyle(color: Color(0xff2F496E), fontSize: 28),
    );
  }
}