import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  final String image;
  final String title;
  
  

  const IntroPage({super.key, 
    required this.image,
    required this.title,
    
  
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          
          
          
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            title,
            style: const TextStyle(
              
              color: Color(0xff3633E0),
          fontFamily: "Inter",
          fontSize: 28.8,
          fontStyle: FontStyle.normal,
          
          
            ),
            textAlign: TextAlign.center,
          ),
        ),
        
      ],
    );
  }
}