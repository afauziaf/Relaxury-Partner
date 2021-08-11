import 'package:get/get.dart';
import '../global/helpers/snackbar.helper.dart';
import '../api/auth.api.dart';
import '../api/profile.api.dart';
import '../global/helpers/storage.dart';
import '../global/routes/name.route.dart';
import '../models/profile/profile.model.dart';

class AuthController extends GetxController {
  // Login
  login({required String username, required String password}) async {
    Response response = await AuthApi(enableLoader: true, enableNotifier: true).login(username: username, password: password);

    if (response.statusCode == 200) {
      if (response.body['access_token'] != null) {
        if (response.body['user_type'] == "0") {
          await Storage(StorageName.token).write("Bearer" + response.body['access_token']);
          await Storage(StorageName.username).write(username);
          await Storage(StorageName.password).write(password);
          await Storage(StorageName.baseUrl).write('https://core.relaxury.io/');

          Response _profileResponse = await ProfileApi().getProfileInfo();
          ProfileModel profileModel = ProfileModel.fromJson(_profileResponse.body['data']);

          await Storage(StorageName.userId).write(profileModel.id);

          Get.offAllNamed(RouteName.main);
        } else {
          AlertSnackbar.open(title: "Access Denied", message: "Please sign up new account to use this application", status: AlertType.warning);
        }
      } else {
        Get.toNamed(RouteName.accountVerification);
      }
    }
  }

  // Reset Password
  resetPassword({required String password, required String confirmPassword, required String code}) async {
    Response response = await AuthApi(enableLoader: true, enableNotifier: true).resetPassword(password: password, confirmPassword: confirmPassword, code: code);

    if (response.statusCode == 200) {
      Get.offAllNamed(RouteName.login);
    }
  }

  // Register
  register({required String username, required String phone, required String password, required String passwordConfirmation, required String email, required String refId}) async {
    Response response = await AuthApi(enableLoader: true, enableNotifier: true).register(username: username, phone: phone, password: password, passwordConfirmation: passwordConfirmation, email: email, refId: refId);

    if (response.statusCode == 200) {
      AuthApi().sendCodeWithEmail(email: email);
      Get.offNamed(RouteName.accountVerification, arguments: email);
    }
  }

  // Account Verification
  accountVerification({required String email, required String code}) async {
    Response response = await AuthApi(enableLoader: true, enableNotifier: true).accountVerification(email: email, code: code);

    print("email: $email");
    print("code: $code");

    if (response.statusCode == 200) {
      Get.offAllNamed(RouteName.login);
    }
  }

  // Send Code With Email
  sendCodeWithEmail({required String email}) async => AuthApi(enableLoader: true, enableNotifier: true).sendCodeWithEmail(email: email);

  // Send Code
  sendCode() async => AuthApi().sendCode();
}

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
