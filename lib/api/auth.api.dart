import 'package:get/get.dart';

import '../global/helpers/api.helper.dart';

class AuthApi extends ApiHelper {
  bool? enableLoader = false;
  bool? enableNotifier = false;

  AuthApi({
    this.enableLoader,
    this.enableNotifier,
  }) : super(
          enableLoader: enableLoader,
          enableNotifier: enableNotifier,
        );

  // Login
  Future<Response> login({required String username, required String password}) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    body['username'] = username;
    body['password'] = password;

    return await post('auth/login', body);
  }

  // Reset Password
  Future<Response> resetPassword({required String password, required String confirmPassword, required String code}) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    body['password'] = password;
    body['password_confirmation'] = confirmPassword;
    body['email'] = code;

    return await post('auth/change-password', body);
  }

  // Register
  Future<Response> register({required String username, required String phone, required String password, required String passwordConfirmation, required String email, required String refId}) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    body['username'] = username;
    body['phone_number'] = phone;
    body['password'] = password;
    body['password_confirmation'] = passwordConfirmation;
    body['email'] = email;
    body['type'] = 0;
    body['ref'] = refId;

    return await post('auth/register', body);
  }

  // Account Verification
  Future<Response> accountVerification({required String email, required String code}) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    body['email'] = email;
    body['code'] = code;

    return await post('auth/verify-code', body);
  }

  // Send Code with Email
  Future<Response> sendCodeWithEmail({required String email}) async {
    Map<String, dynamic> body = Map<String, dynamic>();
    body['email'] = email;

    return await post('auth/resend-code', body);
  }

  // Send Code without Email
  Future<Response> sendCode() async {
    return await get('commission/otp');
  }
}
