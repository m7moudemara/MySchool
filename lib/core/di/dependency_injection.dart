import 'package:MySchool/core/app_session.dart';
import 'package:MySchool/core/network/dio_client.dart';
import 'package:MySchool/features/main_wrapper/domain/entities/user_role.dart';
import 'package:MySchool/features/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:MySchool/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:MySchool/features/notifications/domain/usecases/get_notifications_usecase.dart';
import 'package:MySchool/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:MySchool/features/school/data/data_sources/dio_service.dart';
import 'package:MySchool/features/school/data/data_sources/get_children_usecase_impl.dart';
import 'package:MySchool/features/school/data/data_sources/user_remote_data_source.dart';
import 'package:MySchool/features/school/data/repositories/user_repository_impl.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_parents.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_students.dart';
import 'package:MySchool/features/school/domain/usecases/get_all_teachers.dart';
import 'package:MySchool/features/school/presentation/cubits/children_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/parent_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/student_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/teacher_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:MySchool/features/school/data/data_sources/local_data_source_impl.dart';
import 'package:MySchool/features/school/data/data_sources/intro_local_data_source_impl.dart';
import 'package:MySchool/features/school/data/repositories/splash_repository_impl.dart';
import 'package:MySchool/features/school/data/repositories/intro_repository_impl.dart';

import 'package:MySchool/features/school/domain/usecases/check_first_time_use_case.dart';
import 'package:MySchool/features/school/domain/usecases/mark_intro_seen_usecase.dart';

import 'package:MySchool/features/school/presentation/cubits/splash/splash_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/intro/intro_cubit.dart';

import '../../features/auth/data/data_sources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/cubit/login/login_cubit.dart';

import '../../features/school/data/data_sources/account_selection_local_data_source.dart';
import '../../features/school/data/repositories/account_selection_repository.dart';
import '../../features/school/domain/usecases/select_account_use_case.dart';
import '../../features/school/presentation/cubits/selected_account/account_selection_cubit.dart';

// 🟢 Dio + Remote Data (تعليق حالياً - استخدمه لاحقًا)
//// import 'package:MySchool/core/network/dio_client.dart';
//// import 'package:MySchool/features/school/data/data_sources/remote_data_source_impl.dart';

class AppDependencies {
  late final SplashCubit splashCubit;
  late final IntroCubit introCubit;
  late final LoginCubit loginCubit;
  late final ParentCubit parentCubit;
  late final StudentCubit studentCubit;
  late final TeacherCubit teacherCubit;
  late final ChildrenCubit childrenCubit;
  late final NotificationCubit notificationCubit;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    //! ========================== Splash ====================================
    final splashLocal = LocalDataSourceImpl(prefs); // ✅ Local حالياً
    final splashRepo = SplashRepositoryImpl(splashLocal);
    final checkFirstTimeUseCase = CheckFirstTimeUseCase(splashRepo);
    splashCubit = SplashCubit(checkFirstTimeUseCase);

    /*
    // ❗️✅ لما تكون جاهز تستخدم API (بدل الـ Local) استخدم ده:

    final dio = DioClient.create();
    final splashRemote = RemoteDataSourceImpl(dio); // <-- هنا المصدر بقى من API
    final splashRepo = SplashRepositoryImpl(splashRemote);
    final checkFirstTimeUseCase = CheckFirstTimeUseCase(splashRepo);
    splashCubit = SplashCubit(checkFirstTimeUseCase);
    */

    //! ========================== Intro ====================================
    final introLocal = IntroLocalDataSourceImpl(prefs);
    final introRepo = IntroRepositoryImpl(introLocal);
    final markIntroSeenUseCase = MarkIntroSeenUseCase(introRepo);
    introCubit = IntroCubit(markIntroSeenUseCase);

    /*
    // ❗️✅ ولو قررت تخزن حالة الـ Intro في API مستقبلاً، تعمل Remote DataSource هنا برضو
    */

    //! ========================== Account Selection =========================
    late final AccountSelectionCubit accountSelectionCubit;
    final localDataSource = AccountSelectionLocalDataSource(prefs);
    final repository = AccountSelectionRepository(localDataSource);
    final selectAccountUseCase = SelectAccountUseCase(repository);
    accountSelectionCubit = AccountSelectionCubit(selectAccountUseCase);

    //! ========================== Auth ====================================
    final dio = DioClient.create();
    final authRemoteDataSource = AuthRemoteDataSourceImpl(dio);
    final authRepository = AuthRepositoryImpl(authRemoteDataSource);
    final loginUseCase = LoginUseCase(authRepository);
    loginCubit = LoginCubit(loginUseCase);

    //! ========================== Users ====================================
    // Remote data source
    final userRemoteDataSource = UserRemoteDataSourceImpl();

    // Repository
    final userRepository = UserRepositoryImpl(userRemoteDataSource);

    // UseCases
    final getAllParents = GetAllParents(userRepository);
    final getAllStudents = GetAllStudents(userRepository);
    final getAllTeachers = GetAllTeachers(userRepository);

    // Cubits
    parentCubit = ParentCubit(getAllParents);
    studentCubit = StudentCubit(getAllStudents);
    teacherCubit = TeacherCubit(getAllTeachers);
    //! ========================== Children ====================================
    final dioService = DioService();
    final getChildrenUseCase = GetChildrenUseCaseImpl(dioService);
    childrenCubit = ChildrenCubit(getChildrenUseCase);

    //! ========================== Notifications ============================

    final notificationRemote = NotificationRemoteDataSourceImpl(
      AppSession.currentUser?.type ?? UserType.student,
    );

    final notificationRepo = NotificationRepositoryImpl(notificationRemote);
    final getNotificationsUseCase = GetNotificationsUseCase(notificationRepo);
    notificationCubit = NotificationCubit(getNotificationsUseCase);
  }
}
