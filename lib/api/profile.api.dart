import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import '../global/helpers/api.helper.dart';
import '../models/profile/service.model.dart';
import 'package:http/http.dart' as http;

class ProfileApi extends ApiHelper {
  bool? enableLoader = false;
  bool? enableNotifier = false;

  ProfileApi({
    this.enableLoader,
    this.enableNotifier,
  }) : super(
          enableLoader: enableLoader,
          enableNotifier: enableNotifier,
        );

  // Get Commission
  Future<Response> getCommissionTree() async {
    return await get('commission/get_tree');
  }

  // Get Profile
  Future<Response> getProfileInfo() async {
    return await get('profile/info');
  }

  // Get Profile
  Future<Response> updateAvatar({required File file}) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://core.relaxury.io/api/product/upload-image'));
    request.headers.addAll(headersAuth);
    request.files.add(
      http.MultipartFile.fromBytes(
        'avatar',
        File(file.path).readAsBytesSync(),
        filename: file.path.split("").last,
      ),
    );

    http.Response response = await http.Response.fromStream(await request.send());

    final body = jsonDecode(response.body);

    Map<String, dynamic> postBody = new Map<String, dynamic>();
    postBody['avatar'] = body['url'];

    return await post('profile/edit/avatar', postBody);
  }

  // Update Profile
  Future<Response> updateProfile({String? username, String? phone}) async {
    Map<String, dynamic> body = new Map<String, dynamic>();
    body['avatar'] = username ?? "";
    body['phone'] = phone ?? "";

    return await post('profile/edit', body);
  }

  // Get Commission
  Future<Response> getCommissionInfo() async {
    return await get('commission/info');
  }

  // Get Commssion Package
  Future<Response> getCommissionPackage() async {
    return await get('commission/package');
  }

  // Buy Commssion Package
  Future<Response> buyCommissionPackage({required int packageId, required String code}) async {
    Map<String, dynamic> body = new Map<String, dynamic>();
    body['id_package'] = packageId;
    body['code'] = code;

    return await post('commission/buy', body);
  }

  // Get Profile
  Future<Response> getPartnerInfo() async {
    return await get('product/user');
  }

  // Buy Commssion Package
  Future<Response> partnerRegister({required String nickname, required int genderId, required int birthday, required int height, required int weight, required int bust, required int waist, required int hips, required int provinceId, required List<int> wardIdList, required List<ServiceModel> serviceList, required List<File> galleryList, required String code}) async {
    List<String> imageUrlList = [];

    for (File file in galleryList) {
      var request = http.MultipartRequest('POST', Uri.parse('https://core.relaxury.io/api/product/upload-image'));
      request.headers.addAll(headersAuth);
      request.files.add(
        http.MultipartFile.fromBytes(
          'avatar',
          File(file.path).readAsBytesSync(),
          filename: file.path.split("").last,
        ),
      );

      http.Response response = await http.Response.fromStream(await request.send());

      final body = jsonDecode(response.body);

      imageUrlList.add(body['url']);
    }

    Map<String, dynamic> body = new Map<String, dynamic>();
    body['nickname'] = nickname;
    body['gender_id'] = genderId;
    body['birthday'] = birthday;
    body['height'] = height;
    body['weight'] = weight;
    body['bust'] = bust;
    body['waist'] = waist;
    body['hips'] = hips;
    body['province_id'] = provinceId;
    body['wards'] = wardIdList;
    body['skills'] = serviceList;
    body['image'] = imageUrlList;
    body['desired_price'] = 0;
    body['code'] = code;

    return await post('product/upload', body);
  }

  // Get Profile
  Future<Response> getGenderList() async {
    return await get('genders');
  }

  // Get Profile
  Future<Response> getServiceList() async {
    return await get('skills');
  }

  // Get Profile
  Future<Response> getProvinceList() async {
    return await get('location/provinces');
  }

  // Get Profile
  Future<Response> getWardList(int provinceId) async {
    return await get('location/provinces/$provinceId');
  }
}
