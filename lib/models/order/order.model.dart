class OrderModel {
  OrderModel({
    this.id,
    this.userid,
    this.ordersId,
    this.productId,
    this.confirmSell,
    this.confirmBuy,
    this.status,
    this.price,
    this.skillId,
    this.skillName,
    this.nameWard,
    this.nameProvince,
    this.dateFrom,
    this.dateTo,
    this.note,
    this.usernameUserBuy,
  });

  int? id;
  int? userid;
  int? ordersId;
  int? productId;
  int? confirmSell;
  int? confirmBuy;
  int? status;
  num? price;
  int? skillId;
  String? skillName;
  String? nameWard;
  String? nameProvince;
  DateTime? dateFrom;
  DateTime? dateTo;
  String? note;
  String? usernameUserBuy;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userid: json["userid"],
        ordersId: json["orders_id"],
        productId: json["product_id"],
        confirmSell: json["confirm_sell"],
        confirmBuy: json["confirm_buy"],
        status: json["status"],
        price: json["price"],
        skillId: json["skill_id"],
        skillName: json["skill_name"],
        nameWard: json["name_ward"],
        nameProvince: json["name_province"],
        dateFrom: DateTime.parse(json["date_from"]),
        dateTo: DateTime.parse(json["date_to"]),
        note: json["note"],
        usernameUserBuy: json["username_user_buy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userid": userid,
        "orders_id": ordersId,
        "product_id": productId,
        "confirm_sell": confirmSell,
        "confirm_buy": confirmBuy,
        "status": status,
        "skill_id": skillId,
        "price": price,
        "name_ward": nameWard,
        "name_province": nameProvince,
        "date_from": dateFrom!.toIso8601String(),
        "date_to": dateTo!.toIso8601String(),
        "note": note,
        "username_user_buy": usernameUserBuy,
      };
}
