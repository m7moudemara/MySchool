
import 'package:MySchool/features/auth/presentation/views/create_new_password_view.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/core/constants.dart';
import 'package:MySchool/core/app_session.dart';

class ParentProfileView extends StatelessWidget {
  const ParentProfileView({super.key});
  static const String id = "/ParentProfileView";

  @override
  Widget build(BuildContext context) {
    final IUser? user = AppSession.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user data available")),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Parent Profile", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
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
                          padding: const EdgeInsets.symmetric(horizontal: 61, vertical: 15),
                          child: _buildInfoCard(user,context),
                        ),
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
      ),
    );
  }

  Widget _buildInfoCard(IUser user, context) {
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
          SizedBox(height: 16),
          _buildInfoItem("assets/newPassword.png", "Change Password", () {
            Navigator.pushNamed(
              context,
              CreateNewPasswordView.id,
              arguments: {
                'userId': AppSession.currentUser?.id,
                'isFirstLogin': false,
              },
            );
          }),
          const SizedBox(height: 16),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
