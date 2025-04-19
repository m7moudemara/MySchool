import 'package:MySchool/features/auth/data/mock/verify_code_mock.dart';
import 'package:MySchool/features/main_wrapper/presentation/views/create_new_password_view.dart';
import 'package:MySchool/features/main_wrapper/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});
  static String id = '/ResetPasswordView';

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  bool _isLoading = false;
  late String userId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      setState(() {
        userId = args['userId'];
      });
    });
  }

  String get _enteredCode => _controllers.map((c) => c.text).join();

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
        title: const Text("Reset Password"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Please enter the code we sent you to email",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _controllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.length == 1 && index < 3) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                isLoading: _isLoading,
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });


                  try {
                    final success = await verifyResetCode(_enteredCode);

                    setState(() {
                      _isLoading = false;
                    });

                    if (success) {
                      Navigator.pushNamed(
                        context,
                        CreateNewPasswordView.id,
                        arguments: {'userId': userId},
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Code verified successfully"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Invalid code")),
                      );
                    }
                  } catch (e) {
                    setState(() {
                      _isLoading = false;
                    });


                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Something went wrong: $e")),
                    );
                  }
                },
                text: "Verify",
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Didn’t Receive the Code?",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  "Resend Code",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
