class Message {
  final int? senderId;
  final int? receiverId;
  final String? message;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['sender_id'],
      receiverId: json['reciever_id'],
      message: json['message'],
    );
  }
}
