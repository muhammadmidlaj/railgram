class ReviewModelElement {
  ReviewModelElement(
      {required this.rating, required this.userid, required this.trainno});

  int rating;
  String userid;
  String trainno;

  factory ReviewModelElement.fromJson(Map<String, dynamic> json) =>
      ReviewModelElement(
          rating: json["rating"],
          userid: json["userid"],
          trainno: json["trainno"]);

  Map<String, dynamic> toJson() =>
      {"rating": rating.toString(), "userid": userid, "trainno": trainno};
}
