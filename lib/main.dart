import 'package:MySchool/controllers/shared_pref_controller.dart';
import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/core/presentation/intro/presentation/cubits/intro_cubit.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:MySchool/features/dashbord/presentation/cubits/dashboard_cubit.dart';
import 'package:MySchool/features/grades/presentation/cubits/grade_cubit.dart';
import 'package:MySchool/features/homework/data/home_work/home_work_cubit.dart';
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
