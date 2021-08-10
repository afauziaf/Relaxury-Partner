// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.id,
    this.ref,
    this.sponsorId,
    this.name,
    this.email,
    this.username,
    this.status,
    this.isBuyPackageCommission,
    this.blacklistStatus,
    this.phoneNumber,
    this.type,
    this.nameGender,
    this.birthday,
    this.avatar,
    this.hasProduct,
    this.infoProduct,
  });

  int? id;
  String? ref;
  String? sponsorId;
  String? name;
  String? email;
  String? username;
  int? status;
  int? isBuyPackageCommission;
  int? blacklistStatus;
  String? phoneNumber;
  String? type;
  String? nameGender;
  DateTime? birthday;
  String? avatar;
  int? hasProduct;
  InfoProduct? infoProduct;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json["id"],
        ref: json["ref"],
        sponsorId: json["sponsor_id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        status: json["status"],
        isBuyPackageCommission: json["isBuyPackageCommission"],
        blacklistStatus: json["blacklist_status"],
        phoneNumber: json["phone_number"],
        type: json["type"],
        nameGender: json["name_gender"],
        birthday: DateTime.parse(json["birthday"]),
        avatar: json["avatar"],
        hasProduct: json["hasProduct"],
        infoProduct: InfoProduct.fromJson(json["infoProduct"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "ref": ref,
        "sponsor_id": sponsorId,
        "name": name,
        "email": email,
        "username": username,
        "status": status,
        "isBuyPackageCommission": isBuyPackageCommission,
        "blacklist_status": blacklistStatus,
        "phone_number": phoneNumber,
        "type": type,
        "name_gender": nameGender,
        "birthday": birthday!.toIso8601String(),
        "avatar": avatar,
        "hasProduct": hasProduct,
        "infoProduct": infoProduct!.toJson(),
      };
}

class InfoProduct {
  InfoProduct({
    this.id,
    this.idUser,
    this.nickname,
    this.price,
    this.birthday,
    this.height,
    this.weight,
    this.bust,
    this.hips,
    this.waist,
    this.provinceId,
    this.genderId,
    this.imageNude,
    this.skill,
    this.districts,
  });

  int? id;
  int? idUser;
  String? nickname;
  num? price;
  DateTime? birthday;
  int? height;
  int? weight;
  int? bust;
  int? hips;
  int? waist;
  int? provinceId;
  int? genderId;
  List<ImageNude>? imageNude;
  List<Skill>? skill;
  List<District>? districts;

  factory InfoProduct.fromJson(Map<String, dynamic> json) => InfoProduct(
        id: json["id"],
        idUser: json["id_user"],
        nickname: json["nickname"],
        price: json["price"],
        birthday: DateTime.parse(json["birthday"]),
        height: json["height"],
        weight: json["weight"],
        bust: json["bust"],
        hips: json["hips"],
        waist: json["waist"],
        provinceId: json["province_id"],
        genderId: json["gender_id"],
        imageNude: List<ImageNude>.from(json["imageNude"].map((x) => ImageNude.fromJson(x))),
        skill: List<Skill>.from(json["skill"].map((x) => Skill.fromJson(x))),
        districts: List<District>.from(json["districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "nickname": nickname,
        "price": price,
        "birthday": birthday!.toIso8601String(),
        "height": height,
        "weight": weight,
        "bust": bust,
        "hips": hips,
        "waist": waist,
        "province_id": provinceId,
        "gender_id": genderId,
        "imageNude": List<dynamic>.from(imageNude!.map((x) => x.toJson())),
        "skill": List<dynamic>.from(skill!.map((x) => x.toJson())),
        "districts": List<dynamic>.from(districts!.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.id,
    this.productInfoId,
    this.districtId,
    this.nameDistrict,
  });

  int? id;
  int? productInfoId;
  int? districtId;
  String? nameDistrict;

  factory District.fromJson(Map<String, dynamic> json) => District(
        id: json["id"],
        productInfoId: json["product_info_id"],
        districtId: json["district_id"],
        nameDistrict: json["name_district"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_info_id": productInfoId,
        "district_id": districtId,
        "name_district": nameDistrict,
      };
}

class ImageNude {
  ImageNude({
    this.id,
    this.idUser,
    this.img,
    this.status,
  });

  int? id;
  int? idUser;
  String? img;
  int? status;

  factory ImageNude.fromJson(Map<String, dynamic> json) => ImageNude(
        id: json["id"],
        idUser: json["id_user"],
        img: json["img"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "img": img,
        "status": status,
      };
}

class Skill {
  Skill({
    this.id,
    this.idUser,
    this.idSkills,
    this.price,
    this.nameSkill,
  });

  int? id;
  int? idUser;
  int? idSkills;
  num? price;
  String? nameSkill;

  factory Skill.fromJson(Map<String, dynamic> json) => Skill(
        id: json["id"],
        idUser: json["id_user"],
        idSkills: json["id_skills"],
        price: json["price"],
        nameSkill: json["name_skill"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_skills": idSkills,
        "price": price,
        "name_skill": nameSkill,
      };
}
