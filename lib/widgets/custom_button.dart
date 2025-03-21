
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  const CustomButton({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: 	InkWell(
        onTap: (){},
        child: Container(
          height: 63,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff3620C2),
            borderRadius: BorderRadius.circular(8),
                  
          ),
          child: Center(child: Text(text,style: TextStyle(color: Colors.white),)),
        ),
      ),
    );
  }
}