class ArticleModel {
  final int id;
  final String title;
  final String subtitle;
  final String description;

  ArticleModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
    };
  }
}
