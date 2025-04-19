// lib/features/school/presentation/views/parent/parent_dashboard_view.dart

import 'package:MySchool/features/school/data/config/academics_items_config.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:flutter/material.dart';
import 'package:MySchool/core/app_session.dart';
import 'package:MySchool/features/school/data/models/parent_model.dart';
import 'package:MySchool/features/notifications/presentation/views/notifications_view.dart';
import 'package:MySchool/features/school/presentation/widgets/custom_card_widget.dart';
import 'package:MySchool/features/school/presentation/widgets/custom_academics_widget.dart';

import '../../../../main_wrapper/domain/entities/user_role.dart';

class ParentDashboardView extends StatefulWidget {
  static const String id = '/ParentDashboard';

  const ParentDashboardView({super.key});

  @override
  State<ParentDashboardView> createState() => _ParentDashboardViewState();
}

class _ParentDashboardViewState extends State<ParentDashboardView> {
  Parent? parent;

  @override
  void initState() {
    super.initState();

    final user = AppSession.currentUser;

    if (user is Parent) {
      parent = user;
    } else {
      parent = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: parent == null
          ? const Center(child: Text("No parent data available"))
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                NotificationsView.id,
                              );
                            },
                            icon: const Icon(Icons.notifications),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Welcome back, ${parent!.name}!",
                          style: const TextStyle(
                            color: Color(0xff3F3D56),
                            fontSize: 16,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    SliverToBoxAdapter(
                      child: UserCard(
                        user: parent!,
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    const SliverToBoxAdapter(
                      child: Text(
                        'Academics',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    SliverToBoxAdapter(
                      child: RoleBasedAcademicsCompo(
                        currentUserRole: UserType.parent,
                        items: allAcademicsItems,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
