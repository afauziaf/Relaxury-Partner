class DepositModel {
  DepositModel({
    required this.id,
    required this.idWallet,
    required this.symbol,
    required this.status,
    required this.txhash,
    required this.amount,
    required this.createdAt,
  });

  int id;
  int idWallet;
  dynamic symbol;
  int status;
  String txhash;
  num amount;
  DateTime createdAt;

  factory DepositModel.fromJson(Map<String, dynamic> json) => DepositModel(
        id: json["id"],
        idWallet: json["id_wallet"],
        symbol: json["symbol"],
        status: json["status"],
        txhash: json["txhash"],
        amount: json["amount"],
        createdAt: DateTime.parse(json["created_at"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_wallet": idWallet,
        "symbol": symbol,
        "status": status,
        "txhash": txhash,
        "amount": amount,
        "created_at": createdAt.toIso8601String(),
      };
}
