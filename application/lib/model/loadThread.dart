class Thread {
  int? threadId;
  String? threadTitle;
  String? threadDescription;
  int? likeCount;
  int? verified;
  String? imagePath;
  int? userId;
  String? creationDate;

  Thread({
    this.threadId,
    this.threadTitle,
    this.threadDescription,
    this.likeCount,
    this.verified,
    this.imagePath,
    this.userId,
    this.creationDate,
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      threadId: json['thread_id'],
      threadTitle: json['thread_title'],
      threadDescription: json['thread_description'],
      likeCount: json['like_count'],
      verified: json['verified'],
      imagePath: json['image_path'],
      userId: json['user_id'],
      creationDate: json['creation_date'],
    );
  }
}
