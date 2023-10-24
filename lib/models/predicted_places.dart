class PredictedPlaces {
  String placeId;
  String mainText;
  String secondaryText;

  PredictedPlaces({
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });

  factory PredictedPlaces.fromJson(Map<String, dynamic> jsonData) {
    return PredictedPlaces(
      placeId: jsonData["place_id"],
      mainText: jsonData["structured_formatting"]["main_text"],
      secondaryText: jsonData["structured_formatting"]["secondary_text"],
    );
  }
}
