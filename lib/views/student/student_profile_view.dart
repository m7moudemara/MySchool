import 'package:MySchool/constants.dart';
import 'package:flutter/material.dart';

class StudentProfileView extends StatefulWidget {
  const StudentProfileView({super.key});
  static final String id = "/StudentProfileView";

  @override
  State<StudentProfileView> createState() => _StudentProfileViewState();
}

class _StudentProfileViewState extends State<StudentProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Maison Neue',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(height: 120, color: Colors.white),
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.kSecondaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: EdgeInsets.only(top: 80),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "User Name",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 61,
                            vertical: 15,
                          ),
                          child: _buildInfoCard(),
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -60,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage("assets/profile.png"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 300),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17.20),
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          _buildInfoItem("assets/id.png", "103278999766"),
          SizedBox(height: 16),
          _buildInfoItem("assets/student.png", "Student Class A"),
          SizedBox(height: 16),
          _buildInfoItem("assets/school.png", "Student In High School"),
          SizedBox(height: 16),
          _buildInfoItem("assets/address.png", "Sohag city , Nasser street"),
          SizedBox(height: 16),
          _buildInfoItem("assets/logout.png", "Logout"),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String image, String value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        children: [
          Image.asset(image, width: 24, height: 24),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
