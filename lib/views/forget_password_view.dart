import 'package:flutter/material.dart';
import 'package:my_school/widgets/custom_button.dart';
import 'package:my_school/widgets/custom_text_field.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.center,
          
        
          children: [
            Spacer(flex: 1,),
            ForgetPasswordText(),
            ForgetPasswordImage(),
            EnterEmailText(),
            EmailAddressText(),
            CustomTextField(hintText: "Email address"),
            RememberText(),
            Spacer(flex: 2,),
            CustomButton(text: "Next")
          ],
        ),
      ),
    );
  }
}

class ForgetPasswordImage extends StatelessWidget {
  const ForgetPasswordImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage("assets/forget_password_image.png",),width: 267,height: 267,);
  }
}

class RememberText extends StatelessWidget {
  const RememberText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text("  Remember the password? "),
          InkWell(onTap: (){Navigator.pushNamed(context, '/SignUpView');},
            child: Text("Sign in",style: TextStyle(color: Color(0xff3620C2)),)),
        ],
      ),
    );
  }
}

class EmailAddressText extends StatelessWidget {
  const EmailAddressText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("  Email address",style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}

class EnterEmailText extends StatelessWidget {
  const EnterEmailText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text("Enter your registered email below",style: TextStyle(fontSize: 16),),
    );
  }
}

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("Forgot Password ?",style: TextStyle(color: Color(0xff2F496E),fontSize: 28),);
  }
}