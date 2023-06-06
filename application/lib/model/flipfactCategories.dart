class FlipApiResponse {
  int? success;
  List<FlipDataItem>? data;

  FlipApiResponse({this.success, this.data});

  factory FlipApiResponse.fromJson(Map<String, dynamic> json) {
    return FlipApiResponse(
      success: json['success'],
      data: List<FlipDataItem>.from(
          json['data'].map((item) => FlipDataItem.fromJson(item))),
    );
  }
}

class FlipDataItem {
  String? category;

  FlipDataItem({this.category});

  factory FlipDataItem.fromJson(Map<String, dynamic> json) {
    return FlipDataItem(
      category: json['category'],
    );
  }
}
