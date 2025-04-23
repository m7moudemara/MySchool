import 'package:MySchool/core/presentation/intro/data/data_sources/intro_local_data_source.dart';
import 'package:MySchool/core/presentation/intro/domain/repositories/intro_repository.dart';

class IntroRepositoryImpl implements IntroRepository {
  final IntroLocalDataSource localDataSource;

  IntroRepositoryImpl(this.localDataSource);

  @override
  Future<void> markIntroAsSeen() async {
    await localDataSource.markIntroSeen();
  }
}
