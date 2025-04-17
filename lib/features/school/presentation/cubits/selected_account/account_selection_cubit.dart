import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/features/school/domain/usecases/select_account_use_case.dart';
import 'account_selection_state.dart'; 

class AccountSelectionCubit extends Cubit<AccountSelectionState> {
  final SelectAccountUseCase selectAccountUseCase;

  AccountSelectionCubit(this.selectAccountUseCase) : super(AccountSelectionInitial());
  //! This method is used to save the selected account type
  //! It takes the account type as a parameter and saves it using the SelectAccountUseCase
  //! If the account type is saved successfully, it emits AccountSelectionSuccess state
  Future<void> saveAccountSelection(String accountType) async {
    try {
      await selectAccountUseCase.saveAccountSelection(accountType);
      emit(AccountSelectionSuccess(accountType: accountType));  
    } catch (e) {
      emit(AccountSelectionFailure("Failed to select account"));
    }
  }
  // ! This method is used to get the selected account type
  // ! It retrieves the account type using the SelectAccountUseCase
  void getSelectedAccount() {
    final account = selectAccountUseCase.getAccountSelection();
    if (account != null) {
      emit(AccountSelectionSuccess(accountType: account));
    } else {
      emit(AccountSelectionFailure("No account selected"));
    }
  }
}
