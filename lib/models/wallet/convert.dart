class ConvertModel {
  ConvertModel({
    required this.id,
    required this.from,
    required this.to,
    required this.amount,
    required this.statusName,
    required this.createdAt,
  });

  int id;
  String from;
  String to;
  int amount;
  String statusName;
  DateTime createdAt;

  factory ConvertModel.fromJson(Map<String, dynamic> json) => ConvertModel(
        id: json["id"],
        from: json["from"],
        to: json["to"],
        amount: json["amount"],
        statusName: json["status_name"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from": from,
        "to": to,
        "amount": amount,
        "status_name": statusName,
        "created_at": createdAt.toIso8601String(),
      };
}
