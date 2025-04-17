import 'package:MySchool/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/children_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:MySchool/routes/app_routes.dart';
import 'package:MySchool/features/school/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'core/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final deps = AppDependencies();
  await deps.init();

  runApp(MyApp(deps: deps));
}

class MyApp extends StatelessWidget {
  final AppDependencies deps;

  const MyApp({super.key, required this.deps});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => deps.splashCubit),
        BlocProvider(create: (_) => deps.introCubit),
        BlocProvider<LoginCubit>(create: (_) => deps.loginCubit),
        BlocProvider(create: (_) => deps.parentCubit),
        BlocProvider(create: (_) => deps.studentCubit),
        BlocProvider(create: (_) => deps.teacherCubit),
         BlocProvider(create: (_) => deps.childrenCubit),
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
