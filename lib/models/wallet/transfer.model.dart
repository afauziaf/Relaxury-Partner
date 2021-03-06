class TransferModel {
  TransferModel({
    required this.id,
    required this.userid,
    required this.amount,
    required this.fee,
    required this.fromUsername,
    required this.toUsername,
    required this.status,
    required this.createdAt,
  });

  num id;
  num userid;
  num amount;
  num fee;
  String fromUsername;
  String toUsername;
  num status;
  DateTime createdAt;

  factory TransferModel.fromJson(Map<String, dynamic> json) => TransferModel(
        id: json["id"],
        userid: json["userid"],
        amount: json["amount"],
        fee: json["fee"],
        fromUsername: json["from_username"],
        toUsername: json["to_username"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );
}
