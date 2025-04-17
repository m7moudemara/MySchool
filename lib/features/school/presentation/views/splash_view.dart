import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'intro_view.dart';
import 'select_account_view.dart';
import '../cubits/splash/splash_cubit.dart';
import '../cubits/splash/splash_state.dart';



class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().initSplash(); // Initialize the splash screen
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        //! Listen to the state changes and navigate accordingly
        if (state is SplashNavigateToIntro) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const IntroView()),
          );
        } else if (state is SplashNavigateToSelectAccount) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SelectedAccountView()),
          );
        }
      },
      child: Scaffold(
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
              child: Container(
                width: 19,
                height: 19,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff325CB9),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset("assets/myschool.png"),
              ),
            ),
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
              child: Container(
                width: 19,
                height: 19,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xff0EB4B8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// this is a custom clipper for the left half circle
class HalfCircleClipperLeft extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTRB(size.width / 2, 0, size.width, size.height);
  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}

class HalfCircleClipperRight extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) => Rect.fromLTRB(0, 0, size.width / 2, size.height);
  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => false;
}
