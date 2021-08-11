import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../models/wallet/convert.dart';
import '../../../models/wallet/deposit.model.dart';
import '../../../models/wallet/transfer.model.dart';
import '../../../models/wallet/withdraw.model.dart';
import '../../../controllers/wallet.controller.dart';
import '../../../global/layouts/defauft.layout.dart';
import '../../../models/wallet/transaction.model.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/widgets/gutter.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

  @override
  _TransactionHistoryScreenState createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> {
  WalletController _walletController = Get.find();
  ProfileController _profileController = Get.find();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _walletController.getWalletInfo();
    _walletController.getTransactionList();
    _walletController.update();
    _profileController.getProfileInfo();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WalletController>(
      builder: (controller) {
        return DefaultLayout(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              title: Text("Transaction History"),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.white,
              height: double.infinity,
              child: controller.transactionList.length > 0
                  ? SmartRefresher(
                      enablePullDown: true,
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.all(gutter),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.transactionList.length,
                          itemBuilder: (context, index) {
                            String svgPath = '';
                            DateTime date;
                            String title = '';
                            String subtitle = '';
                            num amount = 0;

                            switch (controller.transactionList[index].transactionType) {
                              case TransactionType.DEPOSIT:
                                {
                                  svgPath = 'assets/icons/deposit.svg';
                                  title = "Depoist";
                                  date = (controller.transactionList[index].transaction as DepositModel).createdAt;
                                  subtitle = (controller.transactionList[index].transaction as DepositModel).txhash;
                                  amount = (controller.transactionList[index].transaction as DepositModel).amount;
                                  break;
                                }
                              case TransactionType.TRANSFER:
                                {
                                  svgPath = 'assets/icons/transfer.svg';
                                  title = "Transfer";
                                  date = (controller.transactionList[index].transaction as TransferModel).createdAt;
                                  subtitle = "From " + (controller.transactionList[index].transaction as TransferModel).fromUsername + " to " + (controller.transactionList[index].transaction as TransferModel).toUsername;
                                  amount = (controller.transactionList[index].transaction as TransferModel).amount;
                                  break;
                                }
                              case TransactionType.CONVERT:
                                {
                                  svgPath = 'assets/icons/convert.svg';
                                  title = "Convert";
                                  date = (controller.transactionList[index].transaction as ConvertModel).createdAt;
                                  subtitle = "From " + (controller.transactionList[index].transaction as ConvertModel).from + " to " + (controller.transactionList[index].transaction as ConvertModel).to;
                                  amount = (controller.transactionList[index].transaction as ConvertModel).amount;
                                  break;
                                }
                              case TransactionType.WITHDRAW:
                                {
                                  svgPath = 'assets/icons/withdraw.svg';
                                  title = "Withdraw";
                                  date = (controller.transactionList[index].transaction as WithdrawModel).createdAt;
                                  subtitle = (controller.transactionList[index].transaction as WithdrawModel).outputAddress.toString();
                                  amount = (controller.transactionList[index].transaction as WithdrawModel).amount!;
                                  break;
                                }
                            }

                            return Card(
                              margin: EdgeInsets.all(0),
                              child: ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  padding: EdgeInsets.all(5),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                  ),
                                  child: SvgPicture.asset(
                                    svgPath,
                                    color: Colors.white,
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      title,
                                      maxLines: 1,
                                      style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Text(
                                      DateFormat('dd/MM/yyyy').format(date),
                                      maxLines: 1,
                                      style: Get.textTheme.bodyText2!.copyWith(color: Colors.grey),
                                    )
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        subtitle,
                                        maxLines: 1,
                                        style: Get.textTheme.bodyText2!.copyWith(color: Colors.grey),
                                      ),
                                    ),
                                    Gutter(),
                                    Text(amount.toStringAsFixed(2) + " \$", style: Get.textTheme.bodyText1!.copyWith(color: primaryColor, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Gutter(),
                        ),
                      ),
                    )
                  : EmptyFileWidget(),
            ),
          ),
        );
      },
    );
  }
}
