import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String label; 
  final TextEditingController controller;
  final String? Function(String?)? validator ;
  const CustomField({
    super.key, required this.label, required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
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
