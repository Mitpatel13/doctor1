class ReviewModel {
  ReviewModel({
    required this.name,
    required this.comment,
  });

  String name;
  String comment;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        name: json["name"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "comment": comment,
      };
}
