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
