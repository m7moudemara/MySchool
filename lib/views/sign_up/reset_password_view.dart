import 'package:MySchool/views/sign_up/create_new_password_view.dart';
import 'package:flutter/material.dart';
import '../../features/school/presentation/widgets/custom_button.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});
  static String id = '/ResetPasswordView';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                  onTap: () {
                    // Validate the code
                    Navigator.pushNamed(context, CreateNewPasswordView.id);
                  },
                  text: "Verify",
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    // Resend code logic
                  },
                  child: const Text(
                    "Didn’t Receive the Code? ",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Resend code logic
                  },
                  child: const Text(
                    "Resend Code",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
