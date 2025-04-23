import 'package:MySchool/core/utils/size_config.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserCard extends StatelessWidget {
  final IUser user;

  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
  SizeConfig.init(context);
    return Container(
      width: double.infinity,
      height: user.type == UserType.parent
    ? SizeConfig.blockSizeVertical * 30 
    : SizeConfig.blockSizeVertical * 20,


      decoration: BoxDecoration(
        color: const Color(0xFF0C46C4),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),

                    child: Center(
                      child: Text(
                        user.displayInfo,
                        style: TextStyle(
                          color: const Color(0xFF121212),
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.imageUrl),
                backgroundColor: Colors.grey[300],
              ),
            ],
          ),

          const Spacer(),

          if (user.type == UserType.student)
            _buildAttendanceSection()
          else if (user.type == UserType.teacher)
            SizedBox()
          else if (user.type == UserType.parent)
            _buildPaymentProgressSection()
          // else if (user.type == UserType.admin)
          // _buildAttendanceSection()
          else
            const SizedBox(),
        ],
      ),
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
              '${((user.totalDays! - user.absentDays!) / user.totalDays! * 100).toStringAsFixed(1)}%',
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

Widget _buildPaymentProgressSection() {
  double paidAmount = 42000;
  double remainingAmount = 72000;
  double schooleFees = paidAmount + remainingAmount;
  final formatCurrency = NumberFormat.decimalPattern();
  String paidFormatted = formatCurrency.format(paidAmount);
  String remainingFormatted = formatCurrency.format(remainingAmount);
  String schoolFeesFormatted = formatCurrency.format(schooleFees);

  return Column(
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
          '$schoolFeesFormatted EP',
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
            '$paidFormatted EP',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          Text(
            '$remainingFormatted EP',
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
              flex: paidAmount.toInt(),
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
              flex: remainingAmount.toInt(),
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
