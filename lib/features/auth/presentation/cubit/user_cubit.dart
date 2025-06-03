// user_cubit.dart
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UserCubit extends Cubit<IUser?> {
  UserCubit() : super(null);

  void setUser(IUser user) {
    emit(user);
  }

  void clearUser() {
    emit(null);
  }
}



class DashboardUserCubit extends Cubit<DashboardUser?> {
  DashboardUserCubit() : super(null);

  void setDashboardUser(DashboardUser dashboardUser) {
    emit(dashboardUser);
  }

  void clearDashboardUser() {
    emit(null);
  }
}
