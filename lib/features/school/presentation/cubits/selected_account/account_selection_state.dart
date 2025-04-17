import 'package:equatable/equatable.dart';  // تأكد من استيراد مكتبة Equatable

abstract class AccountSelectionState extends Equatable {
  const AccountSelectionState();

  @override
  List<Object> get props => [];
}

class AccountSelectionInitial extends AccountSelectionState {}

class AccountSelectionSuccess extends AccountSelectionState {
  final String accountType;

  const AccountSelectionSuccess({required this.accountType});

  @override
  List<Object> get props => [accountType];  // نضيف accountType لكي يتم مقارنة الكائنات بناءً على القيمة
}

class AccountSelectionFailure extends AccountSelectionState {
  final String message;

  const AccountSelectionFailure(this.message);

  @override
  List<Object> get props => [message];  // نضيف message لكي يتم مقارنة الكائنات بناءً على القيمة
}
