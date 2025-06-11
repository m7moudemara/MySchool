import 'package:MySchool/core/utils/size_config.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter/material.dart';

class CustomInfoCardWidget extends StatelessWidget {
  final DashboardUser userx;
  final IUser user;

  const CustomInfoCardWidget({
    super.key,
    required this.user,
    required this.userx,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0C46C4),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        user.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle:
                          user.type == UserType.guardian
                              ? Text(
                                'total students : ${userx.total_students}',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 204),
                                  fontSize: 12,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                              : Text(''),
                      trailing: CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile.png'),
                        backgroundColor: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
              if (user.type == UserType.student)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildAttendanceSection(),
                ),
            ],
          ),
        ),
        if (user.type == UserType.student)
          SizedBox()
        else if (user.type == UserType.teacher)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    width: 168,
                    height: 34,
                    decoration: ShapeDecoration(
                      color: const Color(0x990C46C4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: Container(
                    width: 168,
                    height: 34,
                    decoration: ShapeDecoration(
                      color: const Color(0x990C46C4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        else if (user.type == UserType.guardian)
          _buildPaymentProgressSection(userx)
        else
          const SizedBox(),
      ],
    );
  }

  Widget _buildAttendanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Attendance',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
            Text(
              '${(((user.totalDays ?? 0) - (user.absentDays ?? 0)) / ((user.totalDays ?? 1)) * 100).toStringAsFixed(1)}%',
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),

        const SizedBox(height: 4),

        Container(
          height: 13,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.white),
          ),
          child: Row(
            children: [
              Expanded(
                flex: user.totalDays! - user.absentDays!,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: user.absentDays!,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildPaymentProgressSection(DashboardUser userx) {

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0C46C4),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'School fees',
                style: TextStyle(
                  color: const Color(0xFFB6C8E2),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.02,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Center(
            child: Text(
              '${userx.total} EGP',
              style: TextStyle(
                color: const Color(0xFFF0BC70),
                fontSize: 26,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                letterSpacing: 0.04,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount paid',
                style: TextStyle(
                  color: const Color(0xFFB6C8E2),
                  fontSize: 9.60,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.04,
                ),
              ),
              Text(
                'Amount left',
                style: TextStyle(
                  color: const Color(0xFF868686),
                  fontSize: 13.45,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.03,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${userx.paid} EGP',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Text(
                '${userx.remaining} EGP',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 13,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: userx.paid.toInt(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: userx.remaining.toInt(),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
