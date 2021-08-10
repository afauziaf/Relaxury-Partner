import 'dart:io';

import 'package:get/get.dart';
import '../global/helpers/snackbar.helper.dart';
import '../models/profile/commission_tree.model.dart';
import '../models/profile/partner.model.dart';
import '../api/auth.api.dart';
import '../api/profile.api.dart';
import '../global/helpers/storage.dart';
import '../global/routes/name.route.dart';
import '../models/profile/commission.model.dart';
import '../models/profile/commission_package.model.dart';
import '../models/profile/gender.model.dart';
import '../models/profile/profile.model.dart';
import '../models/profile/province.model.dart';
import '../models/profile/service.model.dart';
import '../models/profile/user_partner.model.dart';
import '../models/profile/ward.model.dart';
import '../models/wallet/bonus.model.dart';

class ProfileController extends GetxController {
  ProfileModel profileModel = new ProfileModel();
  CommissionModel? commissionModel;
  CommissionPackageModel? commissionPackageModel;
  List<BonusModel>? bonusList = [];
  UserPartnerModel? userPartnerModel;
  PartnerModel partnerModel = new PartnerModel();
  CommissionTree? commissionTree;

  List<GenderModel> genderList = [];
  List<ServiceModel> serviceList = [];
  List<ProvinceModel> provinceList = [];

  getCommissionTree() async {
    Response response = await ProfileApi().getCommissionTree();

    commissionTree = CommissionTree.fromJson(response.body['data']['tree']);

    for (CommissionTree child in commissionTree!.children) {
      print("Child: " + child.name);
    }
  }

  getProfileInfo() async {
    Response response = await ProfileApi().getProfileInfo();
    profileModel = ProfileModel.fromJson(response.body['data']);

    getGenderList();
    getServiceList();

    if (profileModel.isBuyPackageCommission == 1) {
      getCommission();
      getCommissionTree();
    }

    if (profileModel.hasProduct == 1) {
      userPartnerModel = UserPartnerModel.fromJson(response.body['data']['infoProduct']);
    }

    getCommissionPackage();

    update();
  }

  editAvatar(File file) async {
    Response response = await ProfileApi(enableLoader: true).updateAvatar(file: file);

    if (response.statusCode == 200) {
      AlertSnackbar.open(title: "Success", message: response.body['message'] ?? "Update avatar completed", status: AlertType.success);

      getProfileInfo();
      update();
    } else {
      print(response.body);
      AlertSnackbar.open(title: "Failed", message: "Update avatar failed", status: AlertType.danger);
    }
  }

  updateProfile({String? username, String? phone}) async {
    Response response = await ProfileApi(enableLoader: true, enableNotifier: true).updateProfile(username: username ?? "", phone: phone ?? "");

    if (response.statusCode == 200) {
      getProfileInfo();
      update();
    }
  }

  registerPartner({required String nickname, required int genderId, required int birthday, required int height, required int weight, required int bust, required int waist, required int hips, required int provinceId, required List<int> wardIdList, required List<ServiceModel> serviceList, required List<File> galleryList, required String code}) async {
    Response response = await ProfileApi(enableLoader: true, enableNotifier: true).partnerRegister(nickname: nickname, genderId: genderId, birthday: birthday, height: height, weight: weight, bust: bust, waist: waist, hips: hips, provinceId: provinceId, wardIdList: wardIdList, serviceList: serviceList, galleryList: galleryList, code: code);

    if (response.statusCode == 200) {
      getProfileInfo();

      while (Get.currentRoute != RouteName.profile) {
        Get.back();
      }
    }
  }

  getCommission() async {
    Response response = await ProfileApi().getCommissionInfo();

    if (response.statusCode == 200) {
      commissionModel = CommissionModel.fromJson(response.body['data']['package_info']);
      bonusList = List<BonusModel>.from((response.body['data']['commissions_history']).map((json) => BonusModel.fromJson(json)));
    }

    update();
  }

  getCommissionPackage() async {
    Response response = await ProfileApi().getCommissionPackage();

    if (response.statusCode == 200) {
      commissionPackageModel = CommissionPackageModel.fromJson(response.body['data']);
    }

    update();
  }

  buyCommissionPackage({required int packageId, required String code}) async {
    Response response = await ProfileApi(enableLoader: true, enableNotifier: true).buyCommissionPackage(packageId: packageId, code: code);

    if (response.statusCode == 200) {
      getProfileInfo();
      Get.back();
      Get.back();
    }
  }

  // Send Code With Email
  sendCodeWithEmail({required String email}) async => AuthApi(enableLoader: true, enableNotifier: true).sendCodeWithEmail(email: email);

  // Send Code
  sendCode() async => AuthApi(enableLoader: true, enableNotifier: true).sendCode();

  // Get Gender
  Future<List<GenderModel>> getGenderList() async {
    Response response = await ProfileApi().getGenderList();
    if (response.statusCode == 200) {
      genderList = List<GenderModel>.from((response.body['data']).map((json) => GenderModel.fromJson(json)));
      return List<GenderModel>.from((response.body['data']).map((json) => GenderModel.fromJson(json)));
    } else {
      return [];
    }
  }

  // Get Gender
  Future<List<ServiceModel>> getServiceList() async {
    Response response = await ProfileApi().getServiceList();
    if (response.statusCode == 200) {
      serviceList = List<ServiceModel>.from((response.body['data']).map((json) => ServiceModel.fromJson(json)));
      return List<ServiceModel>.from((response.body['data']).map((json) => ServiceModel.fromJson(json)));
    } else {
      return [];
    }
  }

  // Get Province
  Future<List<ProvinceModel>> getProvinceList() async {
    Response response = await ProfileApi().getProvinceList();
    if (response.statusCode == 200) {
      provinceList = List<ProvinceModel>.from((response.body).map((json) => ProvinceModel.fromJson(json)));
      return List<ProvinceModel>.from((response.body).map((json) => ProvinceModel.fromJson(json)));
    } else {
      return [];
    }
  }

  // Get Ward
  Future<List<WardModel>> getWardList(int provinceId) async {
    Response response = await ProfileApi().getWardList(provinceId);
    if (response.statusCode == 200) {
      return List<WardModel>.from((response.body).map((json) => WardModel.fromJson(json)));
    } else {
      return [];
    }
  }

  logout() {
    Storage(StorageName.username).write('');
    Storage(StorageName.password).write('');
    Get.offAllNamed(RouteName.login);
  }
}

class ProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
