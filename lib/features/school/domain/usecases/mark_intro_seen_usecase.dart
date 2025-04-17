import '../repositories/intro_repository.dart';

class MarkIntroSeenUseCase {
  final IntroRepository introRepository;

  MarkIntroSeenUseCase(this.introRepository);

  Future<void> call() async {
    await introRepository.markIntroAsSeen();
  }
}
