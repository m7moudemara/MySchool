import 'package:MySchool/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:MySchool/features/notifications/presentation/cubit/notification_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});
  static String id = '/NotificationsView';

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  // todo: Replace mock implementation when backend is ready
  @override
  void initState() {
    super.initState();
    context.read<NotificationCubit>().fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        titleSpacing: 0,
        title: Text(
          "Notification",
          style: TextStyle(
            color: const Color(0xFF161C2B),
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NotificationLoaded) {
            return ListView.builder(
              itemCount: state.notifications.length,
              itemBuilder: (context, index) {
                final n = state.notifications[index];
                DateTime utcTime1 = DateTime.parse(n.date.toString());
                DateTime localTime = utcTime1.add(Duration(hours: 3));
                return ListTile(
                  leading: Image.asset("assets/notificationLocalIcon.png"),
                  title: Text(n.title),
                  subtitle: Text(n.message),
                  trailing: Text(
                    '${localTime.hour}:${localTime.minute}',
                    style: const TextStyle(fontSize: 12),
                  ),
                );
              },
            );
          } else if (state is NotificationError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('No notifications yet.'));
        },
      ),
    );
  }
}
