import 'package:MySchool/core/controllers/file_controller.dart';
import 'package:MySchool/core/controllers/shared_pref_controller.dart';
import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/core/presentation/intro/presentation/cubits/intro_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/class_cubits/add_class_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/fees_cubits/fees_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/parent_cubits/add_parent_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/student_cubits/student_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/subject_cubits/add_subject_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/teacher_cubits/add_teacher_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/timetable_cubits/timetable_cubit.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:MySchool/features/dashbord/presentation/cubits/dashboard_cubit.dart';
import 'package:MySchool/features/grades/presentation/cubits/student/grade_cubit.dart';
import 'package:MySchool/features/grades/presentation/cubits/teacher/cubit/teacher_grade_cubit.dart';
import 'package:MySchool/features/homework/data/home_work/home_work_cubit.dart';
import 'package:MySchool/features/homework/data/teacher/cubit/teacher_home_work_cubit.dart';
import 'package:MySchool/features/homework/data/teacher/cubit/teacher_view_homework_cubit.dart';
import 'package:MySchool/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/children_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/parent_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/student_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/teacher_cubit.dart';
import 'package:MySchool/features/school/presentation/views/student/attendance_student/attendance_student_cubit.dart';
import 'package:MySchool/features/school/presentation/views/teacher/data/classes_cubit.dart';
import 'package:MySchool/features/time_table/presentation/cubits/timetable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:MySchool/routes/app_routes.dart';
import 'package:MySchool/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';

import 'features/school/presentation/views/student/data/attendence_cubit.dart';

SharedPrefController sharedPrefController = SharedPrefController();
FileController fileController = FileController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AttendanceStudentCubit>(
          create: (context) => AttendanceStudentCubit(),
        ),
        BlocProvider<AttendenceCubit>(create: (context) => AttendenceCubit()),
        BlocProvider<HomeWorkCubit>(create: (context) => HomeWorkCubit()),
        BlocProvider<ClassesCubit>(create: (context) => ClassesCubit()),
        BlocProvider<TeacherHomeWorkCubit>(
          create: (context) => TeacherHomeWorkCubit(),
        ),
        BlocProvider<TeacherViewHomeworkCubit>(
          create: (context) => TeacherViewHomeworkCubit(),
        ),
        BlocProvider<TeacherGradeCubit>(
          create: (context) => TeacherGradeCubit(),
        ),
        BlocProvider(create: (_) => getIt<UserCubit>()),
        BlocProvider(create: (_) => getIt<DashboardUserCubit>()),
        BlocProvider(create: (_) => getIt<DashboardCubit>()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => getIt<IntroCubit>()),
        BlocProvider<LoginCubit>(create: (_) => getIt<LoginCubit>()),
        BlocProvider(create: (_) => getIt<ParentCubit>()),
        BlocProvider(create: (_) => getIt<StudentCubit>()),
        BlocProvider(create: (_) => getIt<TeacherCubit>()),
        BlocProvider(create: (_) => getIt<ChildrenCubit>()),
        BlocProvider<NotificationCubit>(
          create: (_) => getIt<NotificationCubit>(),
        ),
        BlocProvider<TimeTableCubit>(create: (_) => getIt<TimeTableCubit>()),
        BlocProvider(create: (_) => getIt<GradeCubit>()),
        BlocProvider<AddClassCubit>(create: (_) => getIt<AddClassCubit>()),
        BlocProvider(create: (_) => getIt<AddSubjectCubit>()),
        BlocProvider(create: (_) => getIt<AddTeacherCubit>()),
        BlocProvider(create: (_) => getIt<AddFeesCubit>()),
        BlocProvider(create: (_) => getIt<AddParentCubit>()),
        BlocProvider(create: (_) => getIt<AddStudentCubit>()),
        BlocProvider(create: (_) => getIt<AddTimeTableCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRoutes.routes,
        initialRoute: '/',
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
