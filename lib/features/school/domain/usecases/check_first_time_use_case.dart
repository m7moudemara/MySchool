import '../repositories/splash_repository.dart';

class CheckFirstTimeUseCase {
  final SplashRepository splashRepository;

  CheckFirstTimeUseCase(this.splashRepository);

  Future<bool> call() async {
    return await splashRepository.isFirstTime();
  }
}
