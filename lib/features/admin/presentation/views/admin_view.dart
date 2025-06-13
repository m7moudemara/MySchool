import 'package:MySchool/core/utils/utils.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/compo.dart';
import '../widgets/custom_card.dart';
import 'classes/add_class_view.dart';
import 'fees/fees_view.dart';
import 'parent/parents_view.dart';
import 'result/results_view.dart';
import 'students/add_students_view.dart';
import 'subjects/add_subjects_view.dart';
import 'teacher/add_teachers_view.dart';
import 'timetable/timetables_view.dart';

class AdminView extends StatefulWidget {
  static String id = '/AdminView';
  AdminView({super.key});

  @override
  State<AdminView> createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  // int totalClasses = 0;
  final List<Compo> items = [
    Compo(
      count: 50,
      image: "assets/classesadmin.png",
      title: "Classes",
      route: AddClassView.id,
    ),
    Compo(
      count: 50,
      image: "assets/subjectsadmin.png",
      title: "Subjects",
      route: AddSubjectView.id,
    ),
    Compo(
      count: 50,
      image: "assets/teachersadmin.png",
      title: "Teachers",
      route: AddTeachersView.id,
    ),
    Compo(
      count: 50,
      image: "assets/parentsadmin.png",
      title: "Parents",
      route: ParentsView.id,
    ),
    Compo(
      count: 50,
      image: "assets/studentsadmin.png",
      title: "Students",
      route: StudentsView.id,
    ),
    Compo(
      count: 50,
      image: "assets/timetablesadmin.png",
      title: "TimeTables",
      route: TimetablesView.id,
    ),
    Compo(
      count: 0,
      image: "assets/feesadmin.png",
      title: "Fees",
      route: FeesView.id,
    ),
    Compo(
      count: 0,
      image: "assets/resultsadmin.png",
      title: "Results",
      route: ResultsView.id,
    ),
  ];
  @override
  void initState() {
    super.initState();
    final user = context.read<UserCubit>();
    final userDash = context.read<DashboardUserCubit>();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("My School"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/schoolIconadmin.png', height: 30),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          //! Image
          SliverToBoxAdapter(
            child: Center(
              child: Image.asset(
                "assets/admindashboard.png",
                width: screenWidth * 1,
                height: screenHeight * 0.1,
                fit: BoxFit.contain,
              ),
            ),
          ),
          //! Components
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: ResponsiveUtils.getGridColumnCount(context),
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1.8,
                ),
                itemBuilder:
                    (context, index) => CustomCard(compo: items[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
