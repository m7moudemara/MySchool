import 'package:shared_preferences/shared_preferences.dart';
import 'local_data_source.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<bool> isFirstTime() async {
    return sharedPreferences.getBool('isFirstTime') ?? true;
  }
}
