class ServiceModel {
  ServiceModel({
    this.id,
    this.name,
    this.price,
  });

  int? id;
  String? name;
  num? price;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "skill_id": id,
        "price": price,
      };
}
