import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home_view.dart';
import 'package:flutter_application_1/widgets/intro_widget.dart';






class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> _pages = [
    const IntroPage(
      color: 0xffffffff,
      image: 'assets/intro1.png',
      title: "Make Your Learning Simple",
     
    ),
    const IntroPage(
      color: 0xfffee8d4,
      image: 'assets/intro2.png',
      title: "Mark Homework as completed ",
     
    ),
    const IntroPage(
      color: 0xffd4f4fe,
      image: 'assets/intro3.png',
      title: "Rectify Your Attendance",
     
    ),
    const IntroPage(
      color: 0xffffd4d4,
      image: 'assets/intro4.png',
      title: "Student Exam & Report Cards",
     
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _pages,
          ),
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage == _pages.length - 1
                    ? ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const HomeView()),
                          );
                        },
                        child: const Text("Start Now"),
                      )
                    : TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: const Text(
                         "Next",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 16,
                          ),
                        ),
                      ),
                Row(
                  children: List.generate(
                    _pages.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}