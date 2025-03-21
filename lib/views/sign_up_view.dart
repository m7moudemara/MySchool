import 'package:flutter/material.dart';
import 'package:my_school/widgets/custom_button.dart';
import 'package:my_school/widgets/custom_text_field.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            SignUpImage(),
            HelloText(),
            CustomTextField(hintText: "Name"),
            SizedBox(height: 10),
            CustomTextField(hintText: "Email"),
            SizedBox(height: 10),
            CustomTextField(hintText: "ID Number"),
            SizedBox(height: 10),
            CustomTextField(hintText: "Password"),
            SizedBox(height: 10),
            CustomButton(text: "Sign Up"),
            HaveAnAccountText(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class SignUpImage extends StatelessWidget {
  const SignUpImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage("assets/signup_image.png"), height: 121);
  }
}

class HelloText extends StatelessWidget {
  const HelloText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello, Sign Up to start using our app",
            style: TextStyle(color: Color(0xff3620C2), fontSize: 16),
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
      padding: const EdgeInsets.only(top: 2.0,left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Have an account "),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(50, 30)
              
            ),
            onPressed: (){
              Navigator.pushNamed(context, '/LoginView');
            },
            child: Text(
              "? Login",
              style: TextStyle(color: Color(0xff3620C2), fontSize: 13.33,),
            ),
          ),
        ],
      ),
    );
  }
}
