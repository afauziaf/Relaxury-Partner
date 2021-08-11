import 'package:get/get.dart';

import '../global/helpers/api.helper.dart';

class WalletApi extends ApiHelper {
  bool? enableLoader = false;
  bool? enableNotifier = false;

  WalletApi({
    this.enableLoader,
    this.enableNotifier,
  }) : super(
          enableLoader: enableLoader,
          enableNotifier: enableNotifier,
        );

  Future<Response> getWalletInfo() async => await get('wallet');
  Future<Response> getDepositList() async => await get('wallet/deposit');
  Future<Response> getTransferList() async => await get('wallet/transfer');
  Future<Response> getConvertList() async => await get('wallet/history/convert');
  Future<Response> getWithdrawList() async => await get('wallet/withdraw');
  Future<Response> getBonusList() async => await get('commission/info');

  Future<Response> transfer({required String username, required num amount, required String code}) async {
    Map<String, dynamic> body = new Map<String, dynamic>();
    body['username'] = username;
    body['amount'] = amount;
    body['otp'] = code;

    return await post('wallet/assets/transfer', body);
  }

  Future<Response> convert({required num walletFrom, required num walletTo, required num amount, required String code}) async {
    Map<String, dynamic> body = new Map<String, dynamic>();
    body['wallet_from'] = walletFrom;
    body['wallet_to'] = walletTo;
    body['amount'] = amount;
    body['otp'] = code;

    return await post('wallet/assets/convert', body);
  }

  Future<Response> withdraw({required String outputAddress, required num amount, required String code}) async {
    Map<String, dynamic> body = new Map<String, dynamic>();
    body['output_address'] = outputAddress;
    body['amount'] = amount;
    body['otp'] = code;

    return await post('wallet/assets/withdraw', body);
  }
}
