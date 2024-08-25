abstract class NotificationEvent {}

class SendNotification extends NotificationEvent {
  final String title;
  final String message;

  SendNotification(this.title, this.message);
}

class GetAllNotifications extends NotificationEvent {}