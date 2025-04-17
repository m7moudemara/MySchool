import 'package:shared_preferences/shared_preferences.dart';
import 'intro_local_data_source.dart';

class IntroLocalDataSourceImpl implements IntroLocalDataSource {
  final SharedPreferences prefs;

  IntroLocalDataSourceImpl(this.prefs);

  @override
  Future<void> markIntroSeen() async {
    await prefs.setBool('isFirstTime', false);
  }
}
