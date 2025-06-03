import 'package:MySchool/core/constants.dart';
import 'package:MySchool/features/homework/data/home_work/home_work_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeworkView extends StatefulWidget {
  const HomeworkView({super.key});
  static String id = '/HomeworkView';

  @override
  State<HomeworkView> createState() => _HomeworkViewState();
}

class _HomeworkViewState extends State<HomeworkView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeWorkCubit>(context).loadHomeWorks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Homework'),
        centerTitle: true,
      ),
      body: BlocConsumer<HomeWorkCubit, HomeWorkState>(
        listener: (context, state) {
          if (state is HomeWorkError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeWorkLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeWorkLoaded) {
            // Replace with your ListView or other widget to display homework items
            return ListView.builder(
              itemCount: state.homeWorks.length,
              itemBuilder: (context, index) {
                final homework = state.homeWorks[index];

                // final eventTime = DateTime.parse(
                //   homework.dueDate.toString(),
                // ); // your future event
                // final now = DateTime.now();

                // final difference = eventTime.difference(now);

                // if (difference.isNegative) {
                //   print("The event has already passed.");
                // } else {
                //   final days = difference.inDays;
                //   final hours = difference.inHours % 24;
                //   final minutes = difference.inMinutes % 60;

                //   print(
                //     "Time left: $days days, $hours hours, $minutes minutes",
                //   );
                // }
                DateTime eventTime = DateTime.parse(homework.dueDate);
                final dueDate = timeago.format(eventTime, locale: 'en_short');
                return homework.is_deadline_passed
                    ? SizedBox.shrink()
                    : _buildHomeworkItem(
                      subject: homework.title,
                      task: homework.description,
                      daysLeft: dueDate,
                      button: SizedBox(
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildActionButton(
                              'Download',
                              onPressed: () {
                                // Handle download action
                              },
                            ),
                            const SizedBox(height: 14),
                            _buildActionButton(
                              'Upload',
                              onPressed: () {
                                // Handle upload action
                              },
                            ),
                          ],
                        ),
                      ),
                    );
              },
            );
          } else if (state is HomeWorkError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildHomeworkItem({
    required String subject,
    required String task,
    required String daysLeft,
    required Widget button,
  }) {
    return Card(
      elevation: 2,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/book.png"),
                      Column(
                        children: [
                          Text(
                            subject,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.access_time, size: 16),
                              const SizedBox(width: 4),
                              Text(
                                daysLeft,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    task,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            button,
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, {required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 36,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(
            AppColors.kSecondaryColor,
          ),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13.91,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
