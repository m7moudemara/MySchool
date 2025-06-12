
import 'package:flutter/material.dart';

class CreateNewWidget extends StatefulWidget {
  final String title;
  final List<Widget> items;

  const CreateNewWidget({
    super.key,
    required this.items,
    required this.title,
  });

  @override
  State<CreateNewWidget> createState() => _CreateNewWidgetState();
}

class _CreateNewWidgetState extends State<CreateNewWidget> {
  bool isButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Colors.black.withAlpha(31)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //! Title
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            //! Inputs
            if (widget.items.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Column(children: widget.items),
              ),
            


          ],
        ),
      ),
    );
  }
}
