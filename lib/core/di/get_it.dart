import 'package:MySchool/core/presentation/intro/data/data_sources/intro_local_data_source_impl.dart';
import 'package:MySchool/core/presentation/intro/data/repositories/intro_repository_impl.dart';
import 'package:MySchool/core/presentation/intro/domain/usecases/mark_intro_seen_usecase.dart';
import 'package:MySchool/core/presentation/intro/presentation/cubits/intro_cubit.dart';
import 'package:MySchool/features/admin/data/data_sources/class_data_sources/class_local_datasource.dart';
import 'package:MySchool/features/admin/data/data_sources/class_data_sources/class_local_datasource_impl.dart';
import 'package:MySchool/features/admin/data/data_sources/fees_data_sources/fees_local_datasources.dart';
import 'package:MySchool/features/admin/data/data_sources/fees_data_sources/fees_local_datasources_impl.dart';
import 'package:MySchool/features/admin/data/data_sources/parent_data_sources/parent_local_data_souces_impl.dart';
import 'package:MySchool/features/admin/data/data_sources/parent_data_sources/parent_local_data_sources.dart';
import 'package:MySchool/features/admin/data/data_sources/student_data_sources/student_local_data_souces_impl.dart';
import 'package:MySchool/features/admin/data/data_sources/student_data_sources/student_local_data_sources.dart';
import 'package:MySchool/features/admin/data/data_sources/subjects_data_sources/subjects_data_sources.dart';
import 'package:MySchool/features/admin/data/data_sources/subjects_data_sources/subjects_data_sources_impl.dart';
import 'package:MySchool/features/admin/data/data_sources/teacher_data_sources/teacher_local_datasource.dart';
import 'package:MySchool/features/admin/data/data_sources/teacher_data_sources/teacher_local_datasource_impl.dart';
import 'package:MySchool/features/admin/data/data_sources/timetable_datasources/timetable_local_datasources.dart';
import 'package:MySchool/features/admin/data/data_sources/timetable_datasources/timetable_local_datasources_impl.dart';
import 'package:MySchool/features/admin/data/repositories/class_repository_impl.dart';
import 'package:MySchool/features/admin/data/repositories/fees_repository_impl.dart';
import 'package:MySchool/features/admin/data/repositories/parents_repository_impl.dart';
import 'package:MySchool/features/admin/data/repositories/student_repository_impl.dart';
import 'package:MySchool/features/admin/data/repositories/subjects_repository_impl.dart';
import 'package:MySchool/features/admin/data/repositories/teacher_repository_impl.dart';
import 'package:MySchool/features/admin/data/repositories/timetable_repository_impl.dart';
import 'package:MySchool/features/admin/domain/repositories/add_timetable_repository.dart';
import 'package:MySchool/features/admin/domain/repositories/class_repository.dart';
import 'package:MySchool/features/admin/domain/repositories/fees_repository.dart';
import 'package:MySchool/features/admin/domain/repositories/parent_respository.dart';
import 'package:MySchool/features/admin/domain/repositories/student_repository.dart';
import 'package:MySchool/features/admin/domain/repositories/subject_repository.dart';
import 'package:MySchool/features/admin/domain/repositories/teacher_repository.dart';
import 'package:MySchool/features/admin/domain/usecases/add_class_usecases.dart';
import 'package:MySchool/features/admin/domain/usecases/add_fess_usecases.dart';
import 'package:MySchool/features/admin/domain/usecases/add_parent_usecases.dart';
import 'package:MySchool/features/admin/domain/usecases/add_student_usecases.dart';
import 'package:MySchool/features/admin/domain/usecases/add_subject_usecases.dart';
import 'package:MySchool/features/admin/domain/usecases/add_teacher_usecases.dart';
import 'package:MySchool/features/admin/domain/usecases/add_timetable_usecases.dart';
import 'package:MySchool/features/admin/presentation/cubits/class_cubits/add_class_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/fees_cubits/fees_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/parent_cubits/add_parent_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/student_cubits/student_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/subject_cubits/add_subject_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/teacher_cubits/add_teacher_cubit.dart';
import 'package:MySchool/features/admin/presentation/cubits/timetable_cubits/timetable_cubit.dart';
import 'package:MySchool/features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:MySchool/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:MySchool/features/auth/domain/repositories/check_first_time_repository.dart';
import 'package:MySchool/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:MySchool/features/auth/domain/usecases/login_usecase.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:MySchool/features/dashbord/presentation/cubits/dashboard_cubit.dart';
import 'package:MySchool/features/grades/data/data_sources/grades_local_datasource.dart';
import 'package:MySchool/features/grades/data/data_sources/grades_local_datasource_impl.dart';
import 'package:MySchool/features/grades/data/repositories/grades_repository_impl.dart';
import 'package:MySchool/features/grades/domain/repositories/grades_repository.dart';
import 'package:MySchool/features/grades/domain/usecases/get_grades_use_case.dart';
import 'package:MySchool/features/grades/presentation/cubits/student/grade_cubit.dart';
import 'package:MySchool/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:MySchool/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:MySchool/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:MySchool/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:MySchool/features/school/data/data_sources/account_selection_local_data_source.dart';
import 'package:MySchool/features/school/data/data_sources/user_remote_data_source.dart';
import 'package:MySchool/features/school/data/repositories/account_selection_repository.dart';
import 'package:MySchool/features/school/data/repositories/user_repository_impl.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_parents.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_students.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_teachers.dart';
import 'package:MySchool/features/school/domain/usecases/select_account_use_case.dart';
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
  getIt.registerLazySingleton<Dio>(()=>Dio());
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);
  getIt.registerFactory(() => DashboardCubit());

  // Register other dependencies...
  await _setupIntroDependencies();
  await _setupAuthDependencies();
  await _setupUserDependencies();
  await _setupNotificationDependencies();
  await _setupTimetableDependencies();
  await _setupGradesDependencies();
  await _setupAdminDependencies();

}

// ============== Module Setup Methods ==============

Future<void> _setupIntroDependencies() async {
  getIt.registerFactory(
    () => IntroLocalDataSourceImpl(getIt<SharedPreferences>()),
  );
  getIt.registerFactory(
    () => IntroRepositoryImpl(getIt<IntroLocalDataSourceImpl>()),
  );
  getIt.registerFactory(
    () => MarkIntroSeenUseCase(getIt<IntroRepositoryImpl>()),
  );
  getIt.registerFactory(() => IntroCubit(getIt<MarkIntroSeenUseCase>()));
}

Future<void> _setupAuthDependencies() async {
  getIt.registerFactory(() => AuthRemoteDataSourceImpl(getIt<Dio>()));
  getIt.registerFactory(
    () => AuthRepositoryImpl(getIt<AuthRemoteDataSourceImpl>()),
  );

  getIt.registerFactory(() => LoginUseCase(getIt<AuthRepositoryImpl>()));
  getIt.registerFactory(
    () => CheckFirstLoginUseCase(getIt<AuthRepositoryImpl>()),
  );
  getIt.registerFactory(
    () => ChangePasswordUseCase(getIt<AuthRepositoryImpl>()),
  );

  getIt.registerFactory(
    () => LoginCubit(
      loginUseCase: getIt<LoginUseCase>(),
      checkFirstLoginUseCase: getIt<CheckFirstLoginUseCase>(),
    ),
  );

  getIt.registerLazySingleton<UserCubit>(() => UserCubit());
  getIt.registerLazySingleton<DashboardUserCubit>(() => DashboardUserCubit());
}

Future<void> _setupUserDependencies() async {
  // Account Selection
  getIt.registerFactory(
    () => AccountSelectionLocalDataSource(getIt<SharedPreferences>()),
  );
  getIt.registerFactory(
    () => AccountSelectionRepository(getIt<AccountSelectionLocalDataSource>()),
  );
  getIt.registerFactory(
    () => SelectAccountUseCase(getIt<AccountSelectionRepository>()),
  );
  getIt.registerFactory(
    () => AccountSelectionCubit(getIt<SelectAccountUseCase>()),
  );

  // Users
  getIt.registerFactory(() => UserRemoteDataSourceImpl());
  getIt.registerFactory(
    () => UserRepositoryImpl(getIt<UserRemoteDataSourceImpl>()),
  );

  getIt.registerFactory(() => GetAllParents(getIt<UserRepositoryImpl>()));
  getIt.registerFactory(() => GetAllStudents(getIt<UserRepositoryImpl>()));
  getIt.registerFactory(() => GetAllTeachers(getIt<UserRepositoryImpl>()));

  getIt.registerFactory(() => ParentCubit(getIt<GetAllParents>()));
  getIt.registerFactory(() => StudentCubit(getIt<GetAllStudents>()));
  getIt.registerFactory(() => TeacherCubit(getIt<GetAllTeachers>()));

  // Children
  // getIt.registerFactory(() => DioService());
  // getIt.registerFactory(() => GetChildrenUseCaseImpl(getIt<DioService>()));
  // getIt.registerFactory(() => ChildrenCubit(getIt<GetChildrenUseCaseImpl>()));
}

Future<void> _setupNotificationDependencies() async {
  getIt.registerFactory(
    () => NotificationRemoteDataSourceImpl(UserType.student
    ),
  );

  getIt.registerFactory(
    () => NotificationRepositoryImpl(getIt<NotificationRemoteDataSourceImpl>()),
  );
  getIt.registerFactory(
    () => GetNotificationsUseCase(getIt<NotificationRepositoryImpl>()),
  );
  getIt.registerFactory(
    () => NotificationCubit(getIt<GetNotificationsUseCase>()),
  );
}

//! TimeTable
Future<void> _setupTimetableDependencies() async {
  getIt.registerFactory(() => TimeTableLocalDataSourceImpl());
  getIt.registerFactory(
    () => TimeTableRepositoryImpl(getIt<TimeTableLocalDataSourceImpl>()),
  );
  getIt.registerFactory(
    () => GetTimetableForDayUseCase(getIt<TimeTableRepositoryImpl>()),
  );
  getIt.registerFactory(
    () => TimeTableCubit(getIt<GetTimetableForDayUseCase>()),
  );
}

//! Grades Feature
Future<void> _setupGradesDependencies() async {
  // Data Source
  getIt.registerLazySingleton<GradesLocalDatasource>(
    () => GradesLocalDatasourceImpl(),
  );

  // Repository
  getIt.registerLazySingleton<GradesRepository>(
    () => GradesRepositoryImpl(getIt()),
  );

  // UseCase
  getIt.registerLazySingleton(() => GetGradesUseCase(getIt()));

  // Cubit
  getIt.registerFactory(() => GradeCubit(getIt()));

}
  //! admin
  Future<void> _setupAdminDependencies()async{
  // class data source
  getIt.registerLazySingleton<ClassLocalDataSource>(
    () => ClassLocalDataSourceImpl(),
  );
  // subjects data source
  getIt.registerLazySingleton<SubjectsLocalDataSource>(
    () => SubjectsLocalDataSourceImpl(),
  );
  // teachers data source 
  getIt.registerLazySingleton<TeacherLocalDataSource>(
    () => TeacherLocalDataSourceImpl(),
  );
  // fees data source
  getIt.registerLazySingleton<FeesLocalDataSource>(
    () => FeesLocalDataSourceImpl(),
  );
  // parents data source
  getIt.registerLazySingleton<ParentLocalDataSource>(
    () => ParentLocalDataSourceImpl(),
  );
  // students data source
  getIt.registerLazySingleton<StudentLocalDataSource>(
    () => StudentLocalDataSourceImpl(),
  );
  // timetable data source
  getIt.registerLazySingleton<AddTimeTableLocalDataSource>(
    () => AddTimeTableLocalDataSourceImpl(),
  );

  // class repository
  getIt.registerLazySingleton<ClassRepository>(
    () => ClassRepositoryImpl(getIt()),
  );
  // subjects repository
  getIt.registerLazySingleton<SubjectRepository>(
    () => SubjectsRepositoryImpl(getIt()),
  );
  // teachers repository
  getIt.registerLazySingleton<TeacherRepository>(
    () => TeachersRepositoryImpl(getIt()),
  );
  // fees repository
  getIt.registerLazySingleton<FeesRepository>(
    () => FeesRepositoryImpl(getIt()),
  );
  // parents repository
  getIt.registerLazySingleton<ParentRepository>(
    () => ParentsRepositoryImpl(getIt()),
  );
  // students repository
  getIt.registerLazySingleton<StudentRepository>(
    () => StudentRepositoryImpl(getIt()),
  );
  // timetable repository
  getIt.registerLazySingleton<AddTimeTableRepository>(
    () => AddTimeTableRepositoryImpl(getIt()),
  );

  // class use cases
  getIt.registerLazySingleton(() => GetClassesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddClassUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateClassUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteClassUseCase(getIt()));
  // subject use cases
  getIt.registerLazySingleton(() => GetSubjectUseCase(getIt()));
  getIt.registerLazySingleton(() => AddSubjectUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateSubjectUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteSubjectUseCase(getIt()));
  // teacher use cases
  getIt.registerLazySingleton(() => GetTeachersUseCase(getIt()));
  getIt.registerLazySingleton(() => AddTeacherUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateTeacherUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteTeacherUseCase(getIt()));
  // fees use cases
  getIt.registerLazySingleton(() => GetFeesUseCase(getIt()));
  getIt.registerLazySingleton(() => AddFeesUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateFeesUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteFeesUseCase(getIt()));
  // parents use cases
  getIt.registerLazySingleton(() => GetParentsUseCase(getIt()));
  getIt.registerLazySingleton(() => AddParentUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateParentUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteParentUseCase(getIt()));
  // students use cases
  getIt.registerLazySingleton(() => GetStudentUseCase(getIt()));
  getIt.registerLazySingleton(() => AddStudentUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateStudentUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteStudentUseCase(getIt()));
  // timetable use cases
  getIt.registerLazySingleton(() => GetTimeTableUseCase(getIt()));
  getIt.registerLazySingleton(() => AddTimeTableUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateTimeTableUseCase(getIt()));
  getIt.registerLazySingleton(() => DeleteTimeTableUseCase(getIt()));
  // class cubit
  getIt.registerFactory(
    () => AddClassCubit(
      getAll: getIt(),
      add: getIt(),
      update: getIt(),
      delete: getIt(),
    ),
  );
  // subject cubit
  getIt.registerLazySingleton(
    () => AddSubjectCubit(
      getAll: getIt(),
      add: getIt(),
      update: getIt(),
      delete: getIt(),
    ),
  );
  // teacher cubit
  getIt.registerLazySingleton(
    () => AddTeacherCubit(
      getAll: getIt(),
      add: getIt(),
      update: getIt(),
      delete: getIt(),
    ),
  );
  // fees cubit
  getIt.registerLazySingleton(
    () => AddFeesCubit(
      getAll: getIt(),
      add: getIt(),
      update: getIt(),
      delete: getIt(),
    ),
  );
  // parent cubit
  getIt.registerLazySingleton(
    () => AddParentCubit(
      getAll: getIt(),
      add: getIt(),
      update: getIt(),
      delete: getIt(),
    ),
  );
  // student cubit
  getIt.registerLazySingleton(
    () => AddStudentCubit(
      getAll: getIt(),
      add: getIt(),
      update: getIt(),
      delete: getIt(),
    ),
  );
  // timetable cubit
  getIt.registerLazySingleton(
    () => AddTimeTableCubit(
      getAll: getIt(),
      add: getIt(),
      update: getIt(),
      delete: getIt(),
    ),
  );
}