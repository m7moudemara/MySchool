import 'package:flutter/material.dart';

class ClassDropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String title;

  const ClassDropdownWidget({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF361FC2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(title, style: TextStyle(color: Colors.white)),
          ),
        ),
        items: items,
        onChanged: onChanged,
        borderRadius: BorderRadius.circular(12),
        icon: const Icon(Icons.arrow_drop_down),
        isExpanded: true,
      ),
    );
  }
}
