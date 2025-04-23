import 'package:MySchool/core/presentation/intro/domain/usecases/mark_intro_seen_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'intro_state.dart';

class IntroCubit extends Cubit<IntroState> {
  final MarkIntroSeenUseCase markIntroSeenUseCase;

  IntroCubit(this.markIntroSeenUseCase) : super(IntroInitial());

  Future<void> completeIntro() async {
    await markIntroSeenUseCase();
    emit(IntroCompleted());
  }
}
