// notification_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_notifications_usecase.dart';
import 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;

  NotificationCubit(this.getNotificationsUseCase) : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationLoading());
    try {
      final notifications = await getNotificationsUseCase();
      emit(NotificationLoaded(notifications));
    } catch (e) {
      emit(NotificationError(e.toString()));
    }
  }
}
