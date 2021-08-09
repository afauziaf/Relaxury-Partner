// To parse this JSON data, do
//
//     final provinceModel = provinceModelFromJson(jsonString);

import 'dart:convert';

ProvinceModel provinceModelFromJson(String str) => ProvinceModel.fromJson(json.decode(str));

String provinceModelToJson(ProvinceModel data) => json.encode(data.toJson());

class ProvinceModel {
  ProvinceModel({
    this.id,
    this.nameProvince,
  });

  int? id;
  String? nameProvince;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        id: json["id"],
        nameProvince: json["name_province"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name_province": nameProvince,
      };
}
