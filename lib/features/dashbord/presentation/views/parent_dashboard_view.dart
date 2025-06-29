import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:MySchool/core/di/get_it.dart';
import 'package:MySchool/features/auth/presentation/cubit/user_cubit.dart';
import 'package:MySchool/features/notifications/presentation/views/notifications_view.dart';
import 'package:MySchool/features/dashbord/presentation/widgets/academics_items_config.dart';
import 'package:MySchool/features/school/data/models/parent_model.dart';
import 'package:MySchool/features/school/domain/entities/user_type.dart';
import 'package:MySchool/features/dashbord/presentation/widgets/custom_info_card_widget.dart';
import 'package:MySchool/features/dashbord/presentation/widgets/custom_academics_widget.dart';

class ParentDashboardView extends StatelessWidget {
  static const String id = '/ParentDashboard';

  const ParentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, IUser?>(
      bloc: getIt<UserCubit>(),
      builder: (context, state) {
        if (state is! Parent) {
          return const Scaffold(
            body: Center(child: Text("No parent data available")),
          );
        }

        final parent = state;

        return BlocBuilder<DashboardUserCubit, DashboardUser?>(
          bloc: getIt<DashboardUserCubit>(),
          builder: (context, statex) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: SafeArea(
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
                            "Welcome back, ${parent.name}!",
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
                        child: CustomInfoCardWidget(
                          user: parent,
                          userx: statex!,
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
                          currentUserRole: UserType.guardian,
                          items: allAcademicsItems,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
