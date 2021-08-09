// To parse this JSON data, do
//
//     final wardModel = wardModelFromJson(jsonString);

import 'dart:convert';

WardModel wardModelFromJson(String str) => WardModel.fromJson(json.decode(str));

String wardModelToJson(WardModel data) => json.encode(data.toJson());

class WardModel {
  WardModel({
    this.id,
    this.nameWard,
    this.provinceId,
  });

  int? id;
  String? nameWard;
  int? provinceId;

  factory WardModel.fromJson(Map<String, dynamic> json) => WardModel(
        id: json["id"],
        nameWard: json["name_ward"],
        provinceId: json["province_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_ward": nameWard,
        "province_id": provinceId,
      };
}
