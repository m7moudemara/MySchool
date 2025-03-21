import 'package:flutter/material.dart';
import 'package:my_school/widgets/custom_button.dart';

import 'package:my_school/widgets/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Spacer(flex: 1,),
            LoginImage(),
            HelloText(),
            SizedBox(height: 5,),
            CustomTextField(hintText: "ID Number",),
            SizedBox(height: 15,),
            CustomTextField(hintText: "Password",),
          
            ForgotPasswordText(),
            CustomButton(text: "Login",),
            SignUpText(),
            Spacer(flex: 2,)
          ],
        ),
      ),
    );
  }
}

class LoginImage extends StatelessWidget {
  const LoginImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage("assets/login_image.png"),height: 238,width: 238,);
  }
}

class HelloText extends StatelessWidget {
  const HelloText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        "Hello, Login to continue using our app",
        style: TextStyle(color: Color(0xff3620C2)),
      ),
    );
  }
}

class SignUpText extends StatelessWidget {
  const SignUpText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [ 
          Text("  Don't have an account "),
          InkWell(
            onTap: (){Navigator.pop(context);},
            child: Text(" ? Sign up", style: TextStyle(color: Color(0xff3620C2)))),
        ],
      ),
    );
  }
}

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(onTap: () {
            Navigator.pushNamed(context, '/ForgetPasswordView');
          }, child: Text("Forgot Password?",style: TextStyle(color: Color(0xff3620C2)),)),
        ],
      ),
    );
  }
}


