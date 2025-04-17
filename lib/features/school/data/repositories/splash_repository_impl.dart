import 'package:MySchool/features/school/data/data_sources/local_data_source.dart';
import 'package:MySchool/features/school/domain/repositories/splash_repository.dart';




class SplashRepositoryImpl implements SplashRepository {
  final LocalDataSource localDataSource;

  SplashRepositoryImpl(this.localDataSource);

  @override
  Future<bool> isFirstTime() async {
    return await localDataSource.isFirstTime();
  }
}
