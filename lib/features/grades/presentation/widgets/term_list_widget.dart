import 'package:flutter/material.dart';

class TermsListWidget extends StatelessWidget {
  final List<String> terms;
  final String selectedTerm;
  final Function(String) onTermSelected;

  const TermsListWidget({
    super.key,
    required this.terms,
    required this.selectedTerm,
    required this.onTermSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children:
              terms.map((term) {
                final isSelected = term == selectedTerm;
                return GestureDetector(
                  onTap: () => onTermSelected(term),
                  child: Container(
                    width: double.infinity,
                      color:
                        isSelected
                            ? const Color(0xff103568).withOpacity(0.1)
                            : Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      term,
                       style: TextStyle(
                        color: isSelected ? Colors.black : Colors.grey,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
