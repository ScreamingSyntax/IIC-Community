class ThreadModel {
  final int threadID;
  final String threadTitle;
  final String threadDescription;
  final int likeCount;
  final int verified;
  final String imagePath;
  final int userID;
  final String creationDate;

  ThreadModel(
      {required this.threadID,
      required this.threadTitle,
      required this.threadDescription,
      required this.likeCount,
      required this.verified,
      required this.imagePath,
      required this.userID,
      required this.creationDate});

  factory ThreadModel.fromJson(Map<String, dynamic> json) {
    return ThreadModel(
        threadID: json['thread_id'],
        threadTitle: json['thread_title'],
        threadDescription: json['thread_description'],
        likeCount: json['like_count'],
        verified: json["verified"],
        imagePath: json["image_path"],
        userID: json["user_id"],
        creationDate: json["creation_date"]);
  }
}
