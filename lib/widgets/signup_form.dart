import 'package:MySchool/widgets/custom_button.dart';
import 'package:MySchool/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(hintText: "Name", validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          }),
          SizedBox(height: 10),
          CustomTextFormField(hintText: "Email", validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            return null;
          }),
          SizedBox(height: 10),
          CustomTextFormField(hintText: "ID Number", validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your ID number';
            }
            return null;
          }),
          SizedBox(height: 10),
          CustomTextFormField(hintText: "Password", validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            return null;
          }),
          SizedBox(height: 10),
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