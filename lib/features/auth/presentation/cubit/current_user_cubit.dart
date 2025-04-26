import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserCubit extends Cubit<IUser?> {
  CurrentUserCubit() : super(null);
  
  //! Set User
  void setUser(IUser user) {
    emit(user);
  }

  //! Clear User
  void clearUser() {
    emit(null);
  }
}
