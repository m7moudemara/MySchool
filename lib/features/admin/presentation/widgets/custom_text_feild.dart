import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String label; 
  final TextEditingController controller;
  final TextInputType? keyboardType ;
  final VoidCallback? onTap;
  final bool? readOnly;
  final bool obscureText ;

   const  CustomField({
    super.key, required this.label, required this.controller,  this.keyboardType, this.onTap, this.readOnly,  this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField( 
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: controller,
        readOnly: readOnly ?? false,
        onTap: onTap,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            decoration: BoxDecoration(
                color: const Color(0xFF361FC2),
                borderRadius: BorderRadius.circular(20)),
            child: Text(
              label,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
