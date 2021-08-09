class WithdrawModel {
  WithdrawModel({
    required this.id,
    required this.idWallet,
    required this.symbol,
    required this.outputAddress,
    required this.amount,
    required this.fee,
    required this.total,
    required this.txhash,
    required this.status,
    required this.createdAt,
  });

  int? id;
  int? idWallet;
  String? symbol;
  String? outputAddress;
  int? amount;
  int? fee;
  int? total;
  String? txhash;
  int? status;
  dynamic createdAt;

  factory WithdrawModel.fromJson(Map<String, dynamic> json) => WithdrawModel(
        id: json["id"],
        idWallet: json["id_wallet"],
        symbol: json["symbol"],
        outputAddress: json["output_address"],
        amount: json["amount"],
        fee: json["fee"],
        total: json["total"],
        txhash: json["txhash"],
        status: json["status"],
        createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_wallet": idWallet,
        "symbol": symbol,
        "output_address": outputAddress,
        "amount": amount,
        "fee": fee,
        "total": total,
        "txhash": txhash,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
