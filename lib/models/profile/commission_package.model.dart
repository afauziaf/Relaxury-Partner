class CommissionPackageModel {
  CommissionPackageModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.period,
    required this.unit,
    required this.content,
  });

  int id;
  String name;
  num amount;
  int period;
  String unit;
  String content;

  factory CommissionPackageModel.fromJson(Map<String, dynamic> json) => CommissionPackageModel(
        id: json["id"],
        name: json["name"],
        amount: json["amount"],
        period: json["period"],
        unit: json["unit"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "period": period,
        "unit": unit,
        "content": content,
      };
}
