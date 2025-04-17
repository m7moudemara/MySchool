import 'package:shared_preferences/shared_preferences.dart';

class AccountSelectionLocalDataSource {
  final SharedPreferences sharedPreferences;

  AccountSelectionLocalDataSource(this.sharedPreferences);
  // saveSelectedAccount
  Future<void> saveSelectedAccount(String accountType) async {
    await sharedPreferences.setString('selectedAccount', accountType);
  }

  // getSelectedAccount
  String? getSelectedAccount() {
    return sharedPreferences.getString('selectedAccount');
  }
}
