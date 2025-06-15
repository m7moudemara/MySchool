import 'dart:convert';
import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentSubmittedHomeworkView extends StatefulWidget {
  const StudentSubmittedHomeworkView({super.key});
  static const String id = '/StudentSubmittedHomeworkView';

  @override
  State<StudentSubmittedHomeworkView> createState() =>
      _StudentSubmittedHomeworkViewState();
}

class _StudentSubmittedHomeworkViewState
    extends State<StudentSubmittedHomeworkView> {
  late Future<List> submissionsx;
  List<Widget> submissionWidgets = [];
  int submitted = 0;
  int missed = 0;
  showWidgets() async {
    List submissions = await getSubmissions(95);
    // print(submissions);
    for (var item in submissions) {
      print(item['assignment']['created_at']);
      setState(() {
        submissionWidgets.add(
          buildHomeworkItem(
            subject: item['assignment']['subject']['name'] ?? '',
            topic: item['assignment']['title'],
            assignDate:
                convertUtcToLocal(item['assignment']['created_at']).toString(),
            status: getStatus(
              item['assignment']['is_deadline_passed'],
              item['submission'],
            ),
            statusColor: getColor(
              item['assignment']['is_deadline_passed'],
              item['submission'],
            ),
          ),
        );
        if (item['submission'] != null) {
          submitted++;
        }
      });
    }
    setState(() {
      submitted = (((submitted + 1) * 100) / (submissions.length)).toInt();
      missed = 100 - submitted;
    });
  }

  DateTime convertUtcToLocal(String date) {
    // The UTC time string
    // String utcString = '2025-06-04T11:17:58.0533333';

    // Parse the UTC time string into a DateTime object
    DateTime utcTime = DateTime.parse(
      date,
    ); // This parses the string into UTC time

    // Convert UTC to local time
    DateTime localTime = utcTime.toLocal();
    return localTime;
  }
  // getDate(DateTime date) {
  //   DateTime utcx = DateTime.utc(date);
  //   return DateFormat(date);
  // }

  Color getColor(bool isDead, Map? submission) {
    if (isDead) {
      if (submission == null) {
        return Color(0xFFF2ABFE);
      } else {
        return Color(0xFF4178D4);
      }
    } else {
      if (submission == null) {
        return Colors.green;
      } else {
        return Color(0xFF4178D4);
      }
    }
  }

  String getStatus(bool isDead, Map? submission) {
    if (isDead) {
      if (submission == null) {
        return 'Missing';
      } else {
        return 'Submitted';
      }
    } else {
      if (submission == null) {
        return 'Pending';
      } else {
        return 'Submitted';
      }
    }
  }

  @override
  void initState() {
    super.initState();
    submissionsx = getSubmissions(95);
    showWidgets();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Homework',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: submissionsx,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                int length = snapshot.data!.length;
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: isSmallScreen ? 16 : 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Total Homework
                      Text(
                        'Total Homework-$length',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.32,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      // Stats Cards
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildStatCard(
                            width: screenWidth * 0.43,
                            percentage: '$missed%',
                            label: 'Missing',
                            color: const Color(0xFFF2ABFE),
                          ),
                          _buildStatCard(
                            width: screenWidth * 0.43,
                            percentage: '$submitted%',
                            label: 'Submitted',
                            color: const Color(0xFF4178D4),
                          ),
                        ],
                      ),
                      ...submissionWidgets,

                      // Homework Items
                      // const SizedBox(height: 56),
                      // _buildHomeworkItem(
                      //   subject: 'Science',
                      //   topic: 'Structure of Atoms',
                      //   assignDate: '10 Oct 25',
                      //   status: 'Submitted',
                      //   statusColor: const Color(0xFF4178D4),
                      // ),

                      // const SizedBox(height: 40),
                      // _buildHomeworkItem(
                      //   subject: 'Mathematics',
                      //   topic: 'Surface Areas and Volumes',
                      //   assignDate: '10 Oct 25',
                      //   status: 'Submitted',
                      //   statusColor: const Color(0xFF4178D4),
                      // ),

                      // const SizedBox(height: 40),
                      // _buildHomeworkItem(
                      //   subject: 'English',
                      //   topic: 'My Bestfriend Essay',
                      //   assignDate: '10 Oct 25',
                      //   status: 'Missing',
                      //   statusColor: const Color(0xFFF2ABFE),
                      // ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('${snapshot.error}'));
              } else {
                return Center(child: Image.asset('assets/loading.gif'));
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required double width,
    required String percentage,
    required String label,
    required Color color,
  }) {
    return Container(
      width: width,
      height: 85,
      padding: const EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: const Color(0x3AA7A7A7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            percentage,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 1.20,
            ),
          ),
          const Spacer(),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 13,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              height: 1.69,
              letterSpacing: 0.20,
            ),
          ),
        ],
      ),
    );
  }

  Future<List> getSubmissions(int studentId) async {
    final url = Uri.parse(
      '$baseUrl/api/students/$studentId/assignments/submissions',
    );
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization': 'Bearer ${await sharedPrefController.getToken()}',
      },
    );
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      return result;
    } else {
      throw Exception('error');
    }
  }
}

Widget buildHomeworkItem({
  required String subject,
  required String topic,
  required String assignDate,
  required String status,
  required Color statusColor,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          subject,
          style: TextStyle(
            color: const Color(0xFF6789CA),
            fontSize: 14,
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.w600,
            height: 1.43,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          topic,
          style: const TextStyle(
            color: Color(0xFF313131),
            fontSize: 14,
            fontFamily: 'SourceSansPro',
            fontWeight: FontWeight.w600,
            height: 1.43,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Assign Date',
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 14,
                fontFamily: 'SourceSansPro',
                fontWeight: FontWeight.w400,
                height: 1.29,
              ),
            ),
            Text(
              assignDate,
              style: const TextStyle(
                color: Color(0xFF3A3A3A),
                fontSize: 12.14,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                height: 1.43,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  height: 1.43,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
