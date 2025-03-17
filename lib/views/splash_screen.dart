import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/views/home_view.dart';
import 'package:flutter_application_1/views/intro_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
      
  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  
  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    await Future.delayed(const Duration(seconds: 3)); 
    if (isFirstTime) {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const IntroView()),
      );
    } else {
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        
        children: [
           Positioned(
              top: 70,
          left: -65,
          child: ClipRect(
            clipper: HalfCircleClipperLeft(),
            child: Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff325CB9),
              ),
            ),
          ),
           ),
           Positioned(
              top: 160,
          left: 10,
          child: ClipRect(
            child: Container(
              width: 19,
              height: 19,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff325CB9),
              ),
            ),
          ),
           ),
          
          Center(child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Image.asset("assets/myschool.png",
            
            ),
          )),
           Positioned(
              bottom: 70,
          right: -65,
          child: ClipRect(
            clipper: HalfCircleClipperRight(),
            child: Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff0EB4B8),
              ),
            ),
          ),
           ),
             Positioned(
              bottom: 160,
          right: 10,
          child: ClipRect(
            child: Container(
              width: 19,
              height: 19,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff0EB4B8),
              ),
            ),
          ),
           ),
        
          
        
          
          
        ],
      ),
    );
  }
}
class HalfCircleClipperLeft extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(size.width / 2, 0, size.width, size.height);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}
class HalfCircleClipperRight extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width / 2, size.height);

  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

