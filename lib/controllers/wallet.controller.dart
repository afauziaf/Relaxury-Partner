import 'package:get/get.dart';
import '../api/auth.api.dart';
import '../api/wallet.api.dart';
import '../models/wallet/convert.dart';
import '../models/wallet/deposit.model.dart';
import '../models/wallet/transaction.model.dart';
import '../models/wallet/transfer.model.dart';
import '../models/wallet/wallet.model.dart';
import '../models/wallet/withdraw.model.dart';

class WalletController extends GetxController {
  WalletModel walletModel = new WalletModel();
  List<TransactionModel> transactionList = [];

  getWalletInfo() async {
    Response response = await WalletApi().getWalletInfo();
    walletModel = WalletModel.fromJson(response.body['data']);

    update();
  }

  getTransactionList() async {
    Response response;

    // Get Deposit History
    response = await WalletApi().getDepositList();
    List<DepositModel> depositHistory = List<DepositModel>.from((response.body['data']).map((json) => DepositModel.fromJson(json)));
    for (DepositModel deposit in depositHistory) transactionList.add(new TransactionModel(transaction: deposit, transactionType: TransactionType.DEPOSIT, createAt: deposit.createdAt));

    // Get Transfer History
    response = await WalletApi().getTransferList();
    List<TransferModel> sendHistory = List<TransferModel>.from((response.body['transfer_sent']).map((json) => TransferModel.fromJson(json)));
    List<TransferModel> receiveHistory = List<TransferModel>.from((response.body['transfer_recive']).map((json) => TransferModel.fromJson(json)));
    for (TransferModel deposit in sendHistory) transactionList.add(new TransactionModel(transaction: deposit, transactionType: TransactionType.TRANSFER, createAt: deposit.createdAt));
    for (TransferModel deposit in receiveHistory) transactionList.add(new TransactionModel(transaction: deposit, transactionType: TransactionType.TRANSFER, createAt: deposit.createdAt));

    // Get Convert History
    response = await WalletApi().getConvertList();
    List<ConvertModel> convertHistory = List<ConvertModel>.from((response.body['data']).map((json) => ConvertModel.fromJson(json)));
    for (ConvertModel deposit in convertHistory) transactionList.add(new TransactionModel(transaction: deposit, transactionType: TransactionType.CONVERT, createAt: deposit.createdAt));

    // Get Withdraw History
    response = await WalletApi().getWithdrawList();
    List<WithdrawModel> withdrawHistory = List<WithdrawModel>.from((response.body['data']).map((json) => WithdrawModel.fromJson(json)));
    for (WithdrawModel deposit in withdrawHistory) transactionList.add(new TransactionModel(transaction: deposit, transactionType: TransactionType.WITHDRAW, createAt: deposit.createdAt));

    // Arrange by date
    transactionList.sort((a, b) {
      return a.createAt.compareTo(b.createAt);
    });

    update();
  }

  // Transfer
  transfer({required String username, required num amount, required String code}) async {
    Response response = await WalletApi(enableLoader: true, enableNotifier: true).transfer(username: username, amount: amount, code: code);

    if (response.statusCode == 200) {
      Get.back();
    }
  }

  // Convert
  convert({required num walletFrom, required num walletTo, required num amount, required String code}) async {
    Response response = await WalletApi(enableLoader: true, enableNotifier: true).convert(walletFrom: walletFrom, walletTo: walletTo, amount: amount, code: code);

    if (response.statusCode == 200) {
      Get.back();
    }
  }

  // Withdraw
  withdraw({required String outputAddress, required num amount, required String code}) async {
    Response response = await WalletApi(enableLoader: true, enableNotifier: true).withdraw(outputAddress: outputAddress, amount: amount, code: code);

    if (response.statusCode == 200) {
      Get.back();
    }
  }

  // Send Code
  sendCode() async => AuthApi().sendCode();

  @override
  void onInit() {
    super.onInit();

    getWalletInfo();
    getTransactionList();
  }
}

class WalletBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController());
  }
}
