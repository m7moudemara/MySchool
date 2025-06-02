import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/profile/presentation/views/help_center_view.dart';
import 'package:MySchool/features/profile/presentation/views/personal_data_view.dart';
import 'package:MySchool/features/profile/presentation/views/setting_view.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:MySchool/features/profile/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});
  static final String id = "/ProfileView";

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    final user = getIt<UserCubit>().state;
    if (user != null) {
      context.read<ProfileCubit>().loadProfile(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Profile", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            return _buildProfileContent(state.user);
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text("No data"));
          }
        },
      ),
    );
  }

  Widget _buildProfileContent(IUser user) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          // CircleAvatar( radius: 60 ,backgroundImage: NetworkImage(user.imageUrl)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              user.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontFamily: 'League Spartan',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildInfoCard(user),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IUser user) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17.20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _buildInfoItem("assets/person.png", "Personal data", () {
            Navigator.pushNamed(context, PersonalDataView.id);
          }),
          SizedBox(height: 16),
          _buildInfoItem("assets/setting.png", "Settings", () {
            Navigator.pushNamed(context, SettingsView.id);
          }),
          SizedBox(height: 16),
          _buildInfoItem("assets/help.png", "Help center", () {
            Navigator.pushNamed(context, HelpCenterView.id);
          }),
          SizedBox(height: 16),
          _buildInfoItem("assets/logout.png.png", "Logout", () {
            logout(context);
          }),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String image, String value, VoidCallback? onTap) {
    return ListTile(
      onTap: onTap,
      leading: Image.asset(image, width: 29, height: 29),
      title: Text(
        value,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 12,
          fontFamily: 'Inter',
          fontWeight: FontWeight.w700,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Color(0xffCAD6FF)),
    );
  }
}
