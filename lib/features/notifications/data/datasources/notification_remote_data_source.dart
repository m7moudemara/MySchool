// todo: Replace mock list with API call when .NET backend is ready
import 'dart:convert';

import 'package:MySchool/core/constants/strings.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/main.dart';
import 'package:http/http.dart' as http;
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final UserType usertype;

  NotificationRemoteDataSourceImpl(this.usertype);

  // @override
  // Future<List<NotificationModel>> getNotifications() async {
  //   await Future.delayed(const Duration(seconds: 1));

  //   // todo: Replace this logic with real API when backend is ready
  //   if (usertype == UserType.student) {
  //     return [
  //       NotificationModel(
  //         id: '1',
  //         title: 'Math Exam',
  //         message: 'Don\'t forget the math exam on Monday.',
  //         date: DateTime.now().subtract(const Duration(hours: 3)),
  //       ),
  //       NotificationModel(
  //         id: '2',
  //         title: 'New Homework',
  //         message: 'You have a new homework in Science.',
  //         date: DateTime.now().subtract(const Duration(days: 1)),
  //       ),
  //     ];
  //   } else if (usertype == UserType.teacher) {
  //     return [
  //       NotificationModel(
  //         id: '1',
  //         title: 'Meeting Reminder',
  //         message: 'Staff meeting tomorrow at 10am.',
  //         date: DateTime.now().subtract(const Duration(hours: 2)),
  //       ),
  //     ];
  //   } else if (usertype == UserType.guardian) {
  //   // } else if (usertype == UserType.parent) {
  //     return [
  //       NotificationModel(
  //         id: '1',
  //         title: 'Attendance Report',
  //         message: 'Your child was absent for 2 days this week.',
  //         date: DateTime.now().subtract(const Duration(days: 2)),
  //       ),
  //     ];
  //   }

  //   return [];
  // }

  @override
  Future<List<NotificationModel>> getNotifications() async {
    String? token = await sharedPrefController.getToken();
    final url = Uri.parse('$baseUrl/api/announcements');
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List result = jsonDecode(response.body)['data'];
      return result
          .map((element) => NotificationModel.fromJson(element))
          .toList();
    } else {
      throw Exception('there is no data');
    }
  }
}
