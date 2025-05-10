import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter/material.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({super.key});
  static const String id = '/PersonalDataView';

  @override
  Widget build(BuildContext context) {
    final IUser? user = getIt<UserCubit>().state;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("No user data available")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Personal Data",
         textAlign: TextAlign.center,
style: TextStyle(
color:  Color(0xFF225FFF),
fontSize: 24,
fontFamily: 'League Spartan',
fontWeight: FontWeight.w600,
),
        ),
        backgroundColor: Colors.transparent,
        
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
             CircleAvatar( radius: 60 ,backgroundImage: NetworkImage(user.imageUrl)),
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
          Text(
    user.name,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: const Color(0xA8868686),
        fontSize: 14.33,
        fontFamily: 'League Spartan',
        fontWeight: FontWeight.w600,
    ),
),

            _buildDataItem("ID", user.id),
            _buildDataItem("Birthday", "Not set"),
            _buildDataItem("Gender", "Not set"),
            _buildDataItem("Address", "Not set"),
            _buildDataItem("Phone", "Not set"),
            _buildDataItem("Email", "Not set"),
          ],
        ),
      ),
    );
  }

  Widget _buildDataItem(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
          
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
