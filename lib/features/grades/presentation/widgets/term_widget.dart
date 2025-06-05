import 'package:flutter/material.dart';

class TermSelectorWidget extends StatelessWidget {
  final String selectedTerm;
  final bool isTermListVisible;
  final VoidCallback onTap;

  const TermSelectorWidget({
    super.key,
    required this.selectedTerm,
    required this.isTermListVisible,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedTerm,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              isTermListVisible ? Icons.arrow_drop_up : Icons.arrow_drop_down,
               color: const Color(0xff103568),
            ),
          ],
        ),
      ),
    );
  }
}
