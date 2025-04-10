import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  final String image;
  final String title;
  
  const IntroPage({
    super.key, 
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Container(
            height: size.height * 0.4, // 40%
            margin: const EdgeInsets.only(bottom: 40),
            child: Image.asset(
              image,
              fit: BoxFit.contain, 
            ),
          ),
          
         
          Text(
            title,
            style: const TextStyle(
              color: Color(0xff3633E0),
              fontFamily: "Inter",
              fontSize: 28,
              fontWeight: FontWeight.w600,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}