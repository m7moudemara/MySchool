import 'package:MySchool/features/auth/data/mock/forgot_password_mock.dart';
import 'package:MySchool/features/main_wrapper/presentation/views/reset_password_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../../../school/presentation/widgets/custom_text_field.dart';

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

class ForgetPasswordForm extends StatefulWidget {
  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
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
  isLoading: _isLoading,
    // TODO: Uncomment the following line when using state management
    // isLoading: state is ForgetPasswordLoading,

  onTap: () async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      // TODO: Uncomment the following line when using state management
      //  context.read<ForgetPasswordCubit>().sendCodeToEmail(email);
      final dio = Dio();

      setState(() {
        _isLoading = true;
      });

      try {
        final response = await dio.get(
          "https://67f2952eec56ec1a36d38b8a.mockapi.io/myschool/users",
        );


        final users = response.data as List;

        final matchedUser = users.firstWhere(
          (user) => user['email'] == email,
          orElse: () => null,
        );

        if (matchedUser != null) {
          final userId = matchedUser['id'];

          Navigator.pushNamed(
            context,
            ResetPasswordView.id,
            arguments: {'userId': userId},
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email not found")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  },
  


            text: "Next",
          ),
// TODO: Uncomment the following line when using state management          
//           BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
//   listener: (context, state) {
//     if (state is ForgetPasswordSuccess) {
//       Navigator.pushNamed(
//         context,
//         ResetPasswordView.id,
//         arguments: {'email': _emailController.text.trim()},
//       );
//     } else if (state is ForgetPasswordError) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text(state.message)),
//       );
//     }
//   },
//   child: const SizedBox.shrink(),
// ),
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


