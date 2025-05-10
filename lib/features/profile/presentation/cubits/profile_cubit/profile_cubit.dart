
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  void loadProfile(IUser user) async {
    emit(ProfileLoading());

    try {
      await Future.delayed(Duration(seconds: 1)); 
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError("Error"));
    }
  }
}
