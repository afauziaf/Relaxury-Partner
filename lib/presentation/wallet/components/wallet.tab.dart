import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controllers/wallet.controller.dart';
import '../../../models/wallet/transaction.model.dart';
import 'wallet_balance.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/widgets/gutter.dart';
import '../screens/transaction_history.screen.dart';
import 'deposit_address.dart';
import 'navigation_buttons.dart';

class WalletTab extends StatefulWidget {
  const WalletTab({
    Key? key,
  }) : super(key: key);

  @override
  _WalletTabState createState() => _WalletTabState();
}

class _WalletTabState extends State<WalletTab> {
  WalletController _walletController = Get.find();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _walletController.getWalletInfo();
    _walletController.getTransactionList();
    _refreshController.refreshCompleted();
    _walletController.update();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: GetBuilder<WalletController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: gutter,
              vertical: gutter,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                WalletBalance(
                  title: 'Live Balance (USDC)',
                  balance: controller.walletModel.balance ?? 0,
                ),
                Gutter(),
                NavigationButtons(),
                Gutter(),
                DepositAddress(address: controller.walletModel.addressWallet ?? " "),
                Gutter(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Transactions",
                      textAlign: TextAlign.start,
                      style: Get.textTheme.headline6!.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Center(
                        child: IconButton(
                          onPressed: () => Get.to(() => TransactionHistoryScreen()),
                          splashRadius: 24,
                          icon: Icon(
                            Icons.chevron_right,
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                controller.transactionList.length > 0
                    ? ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.transactionList.length > 10 ? 10 : controller.transactionList.length,
                        itemBuilder: (context, index) {
                          String svgPath = '';

                          switch (controller.transactionList[index].transactionType) {
                            case TransactionType.DEPOSIT:
                              {
                                svgPath = 'assets/icons/deposit.svg';
                                break;
                              }
                            case TransactionType.TRANSFER:
                              {
                                svgPath = 'assets/icons/transfer.svg';
                                break;
                              }
                            case TransactionType.CONVERT:
                              {
                                svgPath = 'assets/icons/convert.svg';
                                break;
                              }
                            case TransactionType.WITHDRAW:
                              {
                                svgPath = 'assets/icons/withdraw.svg';
                                break;
                              }
                          }

                          return Card(
                            margin: EdgeInsets.all(0),
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: primaryColor,
                                ),
                                child: SvgPicture.asset(svgPath),
                              ),
                              title: Text(
                                "Transaction History",
                                style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                maxLines: 1,
                                style: Get.textTheme.bodyText2!.copyWith(color: Colors.grey),
                              ),
                              trailing: Text(100.toStringAsFixed(2) + " \$", style: Get.textTheme.bodyText1!.copyWith(color: primaryColor, fontWeight: FontWeight.bold)),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Gutter(),
                      )
                    : EmptyFileWidget(),
              ],
            ),
          );
        },
      ),
    );
  }
}
