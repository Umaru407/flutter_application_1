class CookDiaryModel {
  int? id;
  String dishName;
  String? image64bit;
  String mealType; //1早餐 2午餐 3中餐
  DateTime dateTime;

  CookDiaryModel(
      {this.id,
      required this.dishName,
      this.image64bit,
      required this.mealType,
      required this.dateTime});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "name": dishName,
      "image64bit": image64bit,
      "mealType": mealType,
      'dateTime': dateTime.toIso8601String(),
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }


  factory CookDiaryModel.fromMap(Map<String, dynamic> map) {
    return CookDiaryModel(
      id: map["id"],
      dishName: map["name"],
      mealType: map["mealType"],
      image64bit: map["image64bit"],
      dateTime: DateTime.parse(map['dateTime']),
    );
  }


  // factory CookDiaryModel.fromMap(Map<String, dynamic> map) =>  CookDiaryModel(
  //       id: map["id"],
  //       dishName: map["name"],
  //       mealType: map["mealType"],
  //       image64bit: map["image64bit"],
  //       dateTime: DateTime.parse(map['dateTime']),
  //     );
}
