import 'package:MySchool/views/sign_up/login_view.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/widgets/select_widget.dart';

class SelectedAccountView extends StatelessWidget {
  const SelectedAccountView({super.key});
  static String id = '/SelectedAccountView';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Column(
          children: [
            Text("Welcome  !",style : TextStyle(color: Color(0xff2F496E),fontSize: 32),),
            Text("Select Your Account",style : TextStyle(color: Color(0xff3620C2),fontSize: 18.61),),
            Spacer(flex: 1,),
            CircleAboveImagesWithText(),
          Spacer(flex: 2,),
              GoText(),
      
            Spacer(flex: 1,),
      
          ],
        ),
      ),
    );
  }
}

class GoText extends StatelessWidget {
  const GoText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, LoginView.id);
      },
              child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.48),
      color: Color(0xff3620C2),
    ),
    height: 43,
    width: 133.77777099609375,
    child: Center(
      child: Text(
        "Go",
        style: TextStyle(fontSize: 25.48, color: Colors.white),
      ),
    ),
              ),
            );
  }
}