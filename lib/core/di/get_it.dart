import 'package:MySchool/core/network/dio_client.dart';
import 'package:MySchool/core/presentation/intro/data/data_sources/intro_local_data_source_impl.dart';
import 'package:MySchool/core/presentation/intro/data/repositories/intro_repository_impl.dart';
import 'package:MySchool/core/presentation/intro/domain/usecases/mark_intro_seen_usecase.dart';
import 'package:MySchool/core/presentation/intro/presentation/cubits/intro_cubit.dart';
import 'package:MySchool/features/auth/data/data_sources/mock/mock_auth_remote_data_source_impl.dart';
import 'package:MySchool/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:MySchool/features/auth/domain/repositories/check_first_time_repository.dart';
import 'package:MySchool/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:MySchool/features/auth/domain/usecases/login_usecase.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:MySchool/features/dashbord/presentation/cubits/dashboard_cubit.dart';
import 'package:MySchool/features/grades/data/data_sources/results_api.dart';
import 'package:MySchool/features/grades/data/repositories/grades_repository.dart';
import 'package:MySchool/features/grades/domain/usecases/get_grades_use_case.dart';
import 'package:MySchool/features/grades/presentation/cubits/grade_cubit.dart';
import 'package:MySchool/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:MySchool/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:MySchool/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:MySchool/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:MySchool/features/school/data/data_sources/account_selection_local_data_source.dart';
import 'package:MySchool/features/school/data/data_sources/dio_service.dart';
import 'package:MySchool/features/school/data/data_sources/get_children_usecase_impl.dart';
import 'package:MySchool/features/school/data/data_sources/user_remote_data_source.dart';
import 'package:MySchool/features/school/data/repositories/account_selection_repository.dart';
import 'package:MySchool/features/school/data/repositories/user_repository_impl.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_parents.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_students.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_teachers.dart';
import 'package:MySchool/features/school/domain/usecases/select_account_use_case.dart';
import 'package:MySchool/features/school/presentation/cubits/children_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/parent_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/selected_account/account_selection_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/student_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/teacher_cubit.dart';
import 'package:MySchool/features/time_table/data/datasources/timetable_local_data_source_impl.dart';
import 'package:MySchool/features/time_table/data/repositories/timetable_repository_impl.dart';
import 'package:MySchool/features/time_table/domain/usecases/get_timetable_for_day.dart';
import 'package:MySchool/features/time_table/presentation/cubits/timetable_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

final getIt = GetIt.instance;
Future<void> setupDependencies() async {
  // Initialize SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Initialize Dio clients
  getIt.registerSingleton<Dio>(DioClient.create());
  getIt.registerFactory(() => DashboardCubit());
  
  // Register other dependencies...
  await _setupIntroDependencies();
  await _setupAuthDependencies();
  await _setupUserDependencies();
  await _setupNotificationDependencies();
  await _setupTimetableDependencies();
  await _setupGradesDependencies();
  

}

// ============== Module Setup Methods ==============

Future<void> _setupIntroDependencies() async {
  getIt.registerFactory(() => IntroLocalDataSourceImpl(getIt<SharedPreferences>()));
  getIt.registerFactory(() => IntroRepositoryImpl(getIt<IntroLocalDataSourceImpl>()));
  getIt.registerFactory(() => MarkIntroSeenUseCase(getIt<IntroRepositoryImpl>()));
  getIt.registerFactory(() => IntroCubit(getIt<MarkIntroSeenUseCase>()));
}

Future<void> _setupAuthDependencies() async {
  getIt.registerFactory(() => MockAuthRemoteDataSourceImpl(getIt<Dio>()));
  getIt.registerFactory(() => AuthRepositoryImpl(getIt<MockAuthRemoteDataSourceImpl>()));
  
  getIt.registerFactory(() => LoginUseCase(getIt<AuthRepositoryImpl>()));
  getIt.registerFactory(() => CheckFirstLoginUseCase(getIt<AuthRepositoryImpl>()));
  getIt.registerFactory(() => ChangePasswordUseCase(getIt<AuthRepositoryImpl>()));
  
  getIt.registerFactory(() => LoginCubit(
    loginUseCase: getIt<LoginUseCase>(),
    checkFirstLoginUseCase: getIt<CheckFirstLoginUseCase>(),
  ));
  
  getIt.registerLazySingleton<UserCubit>(() => UserCubit());

}

Future<void> _setupUserDependencies() async {
  // Account Selection
  getIt.registerFactory(() => AccountSelectionLocalDataSource(getIt<SharedPreferences>()));
  getIt.registerFactory(() => AccountSelectionRepository(getIt<AccountSelectionLocalDataSource>()));
  getIt.registerFactory(() => SelectAccountUseCase(getIt<AccountSelectionRepository>()));
  getIt.registerFactory(() => AccountSelectionCubit(getIt<SelectAccountUseCase>()));
  
  // Users
  getIt.registerFactory(() => UserRemoteDataSourceImpl());
  getIt.registerFactory(() => UserRepositoryImpl(getIt<UserRemoteDataSourceImpl>()));
  
  getIt.registerFactory(() => GetAllParents(getIt<UserRepositoryImpl>()));
  getIt.registerFactory(() => GetAllStudents(getIt<UserRepositoryImpl>()));
  getIt.registerFactory(() => GetAllTeachers(getIt<UserRepositoryImpl>()));
  
  getIt.registerFactory(() => ParentCubit(getIt<GetAllParents>()));
  getIt.registerFactory(() => StudentCubit(getIt<GetAllStudents>()));
  getIt.registerFactory(() => TeacherCubit(getIt<GetAllTeachers>()));
  
  // Children
  getIt.registerFactory(() => DioService());
  getIt.registerFactory(() => GetChildrenUseCaseImpl(getIt<DioService>()));
  getIt.registerFactory(() => ChildrenCubit(getIt<GetChildrenUseCaseImpl>()));
}

Future<void> _setupNotificationDependencies() async {
  getIt.registerFactory(() => NotificationRemoteDataSourceImpl(
   UserType.student
  ));
  
  getIt.registerFactory(() => NotificationRepositoryImpl(getIt<NotificationRemoteDataSourceImpl>()));
  getIt.registerFactory(() => GetNotificationsUseCase(getIt<NotificationRepositoryImpl>()));
  getIt.registerFactory(() => NotificationCubit(getIt<GetNotificationsUseCase>()));
}

Future<void> _setupTimetableDependencies() async {
  getIt.registerFactory(() => TimeTableLocalDataSourceImpl());
  getIt.registerFactory(() => TimeTableRepositoryImpl(getIt<TimeTableLocalDataSourceImpl>()));
  getIt.registerFactory(() => GetTimetableForDayUseCase(getIt<TimeTableRepositoryImpl>()));
  getIt.registerFactory(() => TimeTableCubit(getIt<GetTimetableForDayUseCase>()));
}

Future<void> _setupGradesDependencies() async {
  getIt.registerFactory(() => ResultsApi(getIt<Dio>()));
  getIt.registerFactory(() => GradesRemoteDataSource(getIt<Dio>()));
  
  getIt.registerFactory(() => GradesRepositoryImpl(getIt<GradesRemoteDataSource>()));
  getIt.registerFactory(() => GetGradesUseCase(getIt<GradesRepositoryImpl>()));
  getIt.registerFactory(() => GradeCubit(getIt<GetGradesUseCase>()));

   

}
