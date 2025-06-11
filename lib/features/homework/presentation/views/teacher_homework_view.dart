import 'package:MySchool/features/homework/data/homework_model.dart';
import 'package:MySchool/features/homework/data/teacher/cubit/teacher_view_homework_cubit.dart';
import 'package:MySchool/features/homework/presentation/views/submitted_homeworks.dart';
import 'package:MySchool/features/homework/presentation/views/teacher_create_homework_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TeacherHomeworkView extends StatefulWidget {
  const TeacherHomeworkView({super.key});
  static final String id = '/TeacherAssignmentsView';

  @override
  _TeacherHomeworkViewState createState() => _TeacherHomeworkViewState();
}

class _TeacherHomeworkViewState extends State<TeacherHomeworkView> {
  @override
  void initState() {
    super.initState();
    // _removeExpiredHomework();
    BlocProvider.of<TeacherViewHomeworkCubit>(context).fetchTeacherHomeWorks();
    setState(() {});
  }

  // void _removeExpiredHomework() {
  //   final now = DateTime.now();
  //   homeWorks.removeWhere((hw) => hw.deadline.isBefore(now));
  // }

  // Local list of homework items
  // This is a mock data list. In a real application, this data would come from a database or API.
  List<HomeworkModel> homeWorks = [];
  // final List<HomeworkEntity> homeworkList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Homework',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<TeacherViewHomeworkCubit, TeacherViewHomeworkState>(
          listener: (context, state) {
          },
          builder: (context, state) {
            if (state is HomeWorksLoaded) {
              homeWorks =
                  state.homeWorks
                      .where((element) => element.is_deadline_passed == false)
                      .toList();
              return Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    //! create homework button
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => const TeacherCreateHomeworkview(),
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C46C4),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'Create Homework',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.30,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Homework: ${homeWorks.length}"),
                        //! Search
                        Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: TextField(
                              cursorHeight: 16,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                hintText: 'Search',
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 2,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Homework list
                    Expanded(
                      child: ListView.builder(
                        itemCount: homeWorks.length,
                        itemBuilder: (context, index) {
                          return _buildHomeworkItem(homeWorks[index]);
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is HomeWorksLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text('No HomeWorks'));
            }
          },
        ),
      ),
    );
  }

  // Widget to build each homework item
  Widget _buildHomeworkItem(HomeworkModel item) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 185,
      decoration: BoxDecoration(
        color: const Color(0xFF0C46C4),
        borderRadius: BorderRadius.only(topRight: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Color(0x7F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image(
                          image: AssetImage("assets/carbon_book.png"),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //! Title
                          Text(
                            item.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          //! Subject
                          Text(
                            item.subject_name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          //! DeadLine
                          Text(
                            DateFormat(
                              'dd/MM/yyyy – hh:mm a',
                            ).format(item.deadline),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  //! Divider
                  Divider(
                    color: const Color(0xFFC9C5C5),
                    thickness: 1,
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //! View Button
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewAttachmentPage(),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.black,
                              size: 16,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              child: Text(
                                'View',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //! Delete Button
                      InkWell(
                        onTap: () {
                          BlocProvider.of<TeacherViewHomeworkCubit>(
                            context,
                          ).deleteHomeWork(item.id);
                          setState(() {
                            homeWorks.remove(item);
                          });
                        },
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.black, size: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 3.0,
                              ),
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
