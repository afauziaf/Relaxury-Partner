import 'dart:convert';

import 'package:http/http.dart' as http;

import '../global/helpers/api.helper.dart';
import '../global/helpers/network.conection.dart';

class CountryProvider extends ApiHelper {
  final NetworkConnection network = new NetworkConnection();

  Future<List<CountryModel>> getCountryList() async {
    http.Response response = await http.get(Uri.parse('https://restcountries.eu/rest/v2/all'));

    List<CountryModel> countryList = [];

    if (response.statusCode == 200) {
      var countryObjsJson = jsonDecode(response.body) as List;
      countryList = countryObjsJson.map((json) => CountryModel.fromJson(json)).toList();
    }

    return countryList;
  }
}

class CountryModel {
  CountryModel({
    required this.name,
    required this.callingCodes,
    required this.nativeName,
    required this.flag,
  });

  String name;
  List<String> callingCodes;
  String nativeName;
  String flag;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        name: json["name"],
        callingCodes: List<String>.from(json["callingCodes"].map((x) => x)),
        nativeName: json["nativeName"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "callingCodes": List<dynamic>.from(callingCodes.map((x) => x)),
        "nativeName": nativeName,
        "flag": flag,
      };
}
