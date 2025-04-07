import 'package:MySchool/constants.dart';
import 'package:MySchool/models/student.dart';
import 'package:MySchool/views/attendance_view.dart';
import 'package:MySchool/views/homework_view.dart';
import 'package:MySchool/views/notifications_view.dart';
import 'package:MySchool/views/result_view.dart';
import 'package:MySchool/widgets/student_card_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  static String id = '/HomeView';

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  Image _getIcon(int index) {
    switch (index) {
      case 0:
        return Image.asset("assets/home.png");
      case 1:
        return Image.asset("assets/chat.png");
      case 2:
        return Image.asset("assets/people.png");
      case 3:
        return Image.asset("assets/person.png");
      default:
        return Image.asset("assets/home.png");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            physics: NeverScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, NotificationsView.id);
                      },
                      icon: Icon(Icons.notifications),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Text(
                    "Hi there, Welcome!",
                    style: TextStyle(
                      color: Color(0xff3F3D56),
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: StudentCard(
                  student: Student(
                    name: 'Example X',
                    className: 'Example X',
                    imageUrl: 'assets/Mini Avatar.png',
                    totalDays: 100,
                    absentDays: 30,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: const Text(
                  'Academics',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: const SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 400,
                  child: GridView.count(
                    shrinkWrap: true,

                    crossAxisCount: 2,
                    children: [
                      AcademicsCompo(
                        onTap: () {
                          Navigator.pushNamed(context, AttendanceView.id);
                        },
                        text: 'Attendance',
                        image: "assets/icon1.png",
                      ),
                      AcademicsCompo(
                        onTap: () {
                          Navigator.pushNamed(context, HomeworkView.id);
                        },
                        text: 'Homework',
                        image: "assets/icon2.png",
                      ),
                      AcademicsCompo(
                        onTap: () {
                          Navigator.pushNamed(context, ResultView.id);
                        },
                        text: 'Result',
                        image: "assets/icon3.png",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
  child: BottomNavigationBar(
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedItemColor: AppColors.kSecondaryColor,
    unselectedItemColor: Color(0xff868686),
    backgroundColor: Colors.transparent, 
    currentIndex: _currentIndex,
    onTap: (index) {
      setState(() {
        _currentIndex = index;
      });
    },
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined, size: 30),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat_outlined, size: 30),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.people_alt_outlined, size: 30),
        label: '',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_outline, size: 30),
        label: '',
      ),
    ],
  ),
),
    );
  }
}

class AcademicsCompo extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback onTap;
  const AcademicsCompo({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            width: 100,
            height: 100,
            decoration: ShapeDecoration(
              color: const Color(0xFFE9F9F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Image(image: AssetImage(image), height: 60, width: 60),
          ),
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
