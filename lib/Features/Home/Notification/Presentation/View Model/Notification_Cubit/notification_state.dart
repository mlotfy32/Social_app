part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}

class hasNotification extends NotificationState {
  final bool hasnotification;

  hasNotification({required this.hasnotification});
}

class NotificationGata extends NotificationState {
  final QuerySnapshot Data;

  NotificationGata({required this.Data});
}
