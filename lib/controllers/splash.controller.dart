import 'package:get/get.dart';
import '../api/auth.api.dart';
import '../api/profile.api.dart';
import '../global/helpers/storage.dart';
import '../global/routes/name.route.dart';
import '../models/profile/profile.model.dart';

class SplashController extends GetxController {
  login() async {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      if (Storage(StorageName.password).read() != null && Storage(StorageName.password).read() != null) {
        Response response = await AuthApi(enableLoader: false, enableNotifier: false).login(username: Storage(StorageName.username).read() ?? "", password: Storage(StorageName.password).read() ?? "");

        if (response.statusCode == 200) {
          if (response.body['access_token'] != null) {
            await Storage(StorageName.token).write("Bearer" + response.body['access_token']);
            await Storage(StorageName.baseUrl).write('https://core.relaxury.io/');

            Response _profileResponse = await ProfileApi().getProfileInfo();
            ProfileModel profileModel = ProfileModel.fromJson(_profileResponse.body['data']);

            await Storage(StorageName.userId).write(profileModel.id);

            Get.offNamed(RouteName.main);
          } else {
            Get.offNamed(RouteName.login);
          }
        } else {
          Get.offNamed(RouteName.login);
        }
      } else {
        Get.offNamed(RouteName.login);
      }
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await login();
  }
}

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
