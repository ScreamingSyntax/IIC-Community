class ThreeFlipFact {
  int? cardId;
  String? cardTitle;
  String? cardDescription;
  String? creationDate;
  String? category;
  int? userId;

  ThreeFlipFact({
    this.cardId,
    this.cardTitle,
    this.cardDescription,
    this.creationDate,
    this.category,
    this.userId,
  });

  factory ThreeFlipFact.fromJson(Map<String, dynamic> json) {
    return ThreeFlipFact(
      cardId: json['card_id'],
      cardTitle: json['card_title'],
      cardDescription: json['card_description'],
      creationDate: json['creation_date'],
      category: json['category'],
      userId: json['user_id'],
    );
  }
}
