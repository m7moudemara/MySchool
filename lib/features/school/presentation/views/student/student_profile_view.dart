import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/app_session.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/school/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:MySchool/features/school/presentation/cubits/profile_cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentProfileView extends StatefulWidget {
  const StudentProfileView({super.key});
  static final String id = "/StudentProfileView";

  @override
  State<StudentProfileView> createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  @override
  void initState() {
    super.initState();
    final user = AppSession.currentUser;
    if (user != null) {
      context.read<ProfileCubit>().loadProfile(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.black)),
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
    return Column(
      children: [
        Container(height: 120),
        Expanded(
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColors.kSecondaryColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                padding: const EdgeInsets.only(top: 80),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 61,
                          vertical: 15,
                        ),
                        child: _buildInfoCard(user),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -60,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
              ),
            ],
          ),
        ),
      ],
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
          _buildInfoItem("assets/id.png", user.id, null),
          const SizedBox(height: 16),
          _buildInfoItem("assets/student.png", "Student Class A", null),
          const SizedBox(height: 16),
          _buildInfoItem("assets/school.png", "Student In High School", null),
          const SizedBox(height: 16),
          _buildInfoItem(
            "assets/address.png",
            "Sohag city , Nasser street",
            null,
          ),
          SizedBox(height: 16),
          _buildInfoItem("assets/logout.png", "Logout", () {
            logout(context);
          }),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String image, String value, VoidCallback? onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          children: [
            Image.asset(image, width: 24, height: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
