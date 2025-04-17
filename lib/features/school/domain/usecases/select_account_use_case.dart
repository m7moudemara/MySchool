import 'package:MySchool/features/school/data/repositories/account_selection_repository.dart';

class SelectAccountUseCase {
  final AccountSelectionRepository repository;

  SelectAccountUseCase(this.repository);

  Future<void> saveAccountSelection(String accountType) async {
    await repository.saveSelectedAccount(accountType);
  }

  String? getAccountSelection() {
    return repository.getSelectedAccount();
  }
}
