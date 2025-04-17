


import 'package:MySchool/features/school/presentation/cubits/intro/intro_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/intro/intro_state.dart';
import 'package:MySchool/features/school/presentation/widgets/intro_page.dart';
import 'package:MySchool/features/school/presentation/views/select_account_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class IntroView extends StatefulWidget {
  const IntroView({super.key});
  static const String id = "/IntroView";

  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Widget> _introPages = const [
    IntroPage(
      image: 'assets/intro1.png',
      title: "Make Your Learning Simple",
    ),
    IntroPage(
      image: 'assets/intro2.png',
      title: "Mark Homework as completed",
    ),
    IntroPage(
      image: 'assets/intro3.png',
      title: "Rectify Your Attendance",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<IntroCubit, IntroState>(
      listener: (context, state) {
        if (state is IntroCompleted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const SelectedAccountView()),
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 10,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() => _currentPage = page);
                },
                children: _introPages,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _introPages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.blue : Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: InkWell(
                onTap: () => context.read<IntroCubit>().completeIntro(),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff3620C2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 51,
                  width: 327,
                  child: const Center(
                    child: Text(
                      "Get Started",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
