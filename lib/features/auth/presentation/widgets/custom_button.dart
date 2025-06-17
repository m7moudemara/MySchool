import 'package:MySchool/core/constants/constants.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        child: Container(
          height: 63,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isLoading
                ? AppColors.kSecondaryColor.withValues(alpha:  1.5)
                : AppColors.kSecondaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                  ),
          ),
        ),
      ),
    );
  }
}
