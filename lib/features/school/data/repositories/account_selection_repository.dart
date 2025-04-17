import 'package:MySchool/features/school/data/data_sources/account_selection_local_data_source.dart';

class AccountSelectionRepository {
  final AccountSelectionLocalDataSource localDataSource;

  AccountSelectionRepository(this.localDataSource);

  Future<void> saveSelectedAccount(String accountType) async {
    await localDataSource.saveSelectedAccount(accountType);
  }

  String? getSelectedAccount() {
    return localDataSource.getSelectedAccount();
  }
}
