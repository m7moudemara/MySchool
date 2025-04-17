
import 'package:MySchool/core/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap ;
  const CustomButton({
    super.key, required this.text,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: 	InkWell(
        onTap: onTap,
        child: Container(
          height: 63,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.kSecondaryColor,
            borderRadius: BorderRadius.circular(8),
                  
          ),
          child: Center(child: Text(text,style: TextStyle(color: Colors.white),)),
        ),
      ),
    );
  }
}