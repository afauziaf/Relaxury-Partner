import 'dart:io';

import 'service.model.dart';

class PartnerModel {
  // Infomation
  late String nickname;
  late int genderId;
  late int birthday;
  late int height;
  late int weight;
  late int bust;
  late int waist;
  late int hips;

  // Service
  late List<ServiceModel> serviceList = [];

  // Location
  late int provinceId;
  late List<int> wardIdList = [];

  // Gallery
  late List<File> gallery = [];
}
