import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/auth/presentation/views/create_new_password_view.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});
  static const String id = "/SettingsView";

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _notificationsEnabled = true; 

  @override
  Widget build(BuildContext context) {
    final user = getIt<UserCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings",   textAlign: TextAlign.center,
style: TextStyle(
color:  Color(0xFF225FFF),
fontSize: 24,
fontFamily: 'League Spartan',
fontWeight: FontWeight.w600,
),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildNotificationSwitch(),
            const SizedBox(height: 30),
            _buildChangePasswordButton(user?.id),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSwitch() {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      leading: Image.asset('assets/notification.png'),
      title: 
        const Text(
          "Notification Setting",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        trailing: 
        Switch(
          activeTrackColor:  Color(0xff2260FF),
          value: _notificationsEnabled,
          onChanged: (val) {
            setState(() {
              _notificationsEnabled = val;
            });
          },
        ),
    );
  }

  Widget _buildChangePasswordButton(String? userId) {
    return ListTile(
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      onTap: () {
        Navigator.pushNamed(
          context,
          CreateNewPasswordView.id,
          arguments: {
            'userId': userId,
            'isFirstLogin': false,
          },
        );
      },
      leading: Image.asset("assets/newPassword.png", width: 29, height: 29),
      title: const Text(
        "Change Password",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Color(0xff2260FF)),
    );
  }
}
