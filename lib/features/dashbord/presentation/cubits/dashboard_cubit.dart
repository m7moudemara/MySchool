import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  void loadUser(IUser user) {
    emit(DashboardLoaded(user));
  }
}
