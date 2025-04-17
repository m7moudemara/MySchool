import 'package:MySchool/features/school/data/data_sources/intro_local_data_source.dart';
import 'package:MySchool/features/school/domain/repositories/intro_repository.dart';

class IntroRepositoryImpl implements IntroRepository {
  final IntroLocalDataSource localDataSource;

  IntroRepositoryImpl(this.localDataSource);

  @override
  Future<void> markIntroAsSeen() async {
    await localDataSource.markIntroSeen();
  }
}
