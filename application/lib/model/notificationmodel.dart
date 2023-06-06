class NotificationModel {
  int notificationId;
  String sender;
  String subject;
  String description;

  NotificationModel({
    required this.notificationId,
    required this.sender,
    required this.subject,
    required this.description,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notification_id'],
      sender: json['sender'],
      subject: json['subject'],
      description: json['description'],
    );
  }
}
