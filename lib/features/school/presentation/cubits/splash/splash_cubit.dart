import 'package:MySchool/features/school/domain/usecases/check_first_time_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final CheckFirstTimeUseCase checkFirstTimeUseCase;

  SplashCubit(this.checkFirstTimeUseCase) : super(SplashInitial());
  //! Initialize the splash screen
  //! and check if it's the first time the user is using the app
  //! If it's the first time, navigate to the intro screen
  //! Otherwise, navigate to the select account screen
  //! This is done using the CheckFirstTimeUseCase
  Future<void> initSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    final isFirstTime = await checkFirstTimeUseCase();
    if (isFirstTime) {
      emit(SplashNavigateToIntro());
    } else {
      emit(SplashNavigateToSelectAccount());
    }
  }
}
