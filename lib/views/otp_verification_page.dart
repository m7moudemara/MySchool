import 'package:MySchool/constants.dart';
import 'package:MySchool/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OTPVerificationView extends StatefulWidget {
  static String id = "/OTPVerificationView";
  @override
  _OTPVerificationViewState createState() => _OTPVerificationViewState();
}

class _OTPVerificationViewState extends State<OTPVerificationView> {
  final List<TextEditingController> _otpControllers = List.generate(4, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();

  void _verifyOTP() {
    if (_formKey.currentState!.validate()) {
      String otp = _otpControllers.map((controller) => controller.text).join();
      

      if (otp == "1234") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم التحقق بنجاح!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('رمز OTP غير صحيح!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OtpText(),
              Image.asset(
                'assets/undraw_verified_re_4io7 1.png',
                width: 286,
                height: 288,
              ),
              
              SendText(),
              Text("( example123@gmail.com )",), 
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: _otpControllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        if (value.length == 1 && index < 3) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              Text('00.30'),
              Row(
                children: [
                  Text("Do not send OTP ?"),
                  GestureDetector(
                    onTap: (){},
                    child: Text('Send OTP',style: TextStyle(color: AppColors.kSecondaryColor,)))
                ],
              ),
              CustomButton(
                text:'Verify',
                onTap: _verifyOTP,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SendText extends StatelessWidget {
  const SendText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        'We will send you one time password to this email address.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15, color: Colors.grey),
      ),
    );
  }
}

class OtpText extends StatelessWidget {
  const OtpText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        'OTP Verification',
        style: TextStyle(fontSize: 30, color: AppColors.kSecondaryColor,fontFamily: "Outfit",),
      ),
    );
  }
}