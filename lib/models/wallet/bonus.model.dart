// To parse this JSON data, do
//
//     final bonusModel = bonusModelFromJson(jsonString);

import 'dart:convert';

BonusModel bonusModelFromJson(String str) => BonusModel.fromJson(json.decode(str));

String bonusModelToJson(BonusModel data) => json.encode(data.toJson());

class BonusModel {
  BonusModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.message,
    required this.commissionType,
    required this.status,
    required this.createdAt,
  });

  int id;
  String name;
  num amount;
  String message;
  String commissionType;
  int status;
  DateTime createdAt;

  factory BonusModel.fromJson(Map<String, dynamic> json) => BonusModel(
        id: json["id"],
        name: json["name"],
        amount: json["amount"].toDouble(),
        message: json["message"],
        commissionType: json["commission_type"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "amount": amount,
        "message": message,
        "commission_type": commissionType,
        "status": status,
        "created_at": createdAt.toIso8601String(),
      };
}
