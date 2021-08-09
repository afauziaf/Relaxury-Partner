import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/wallet.controller.dart';
import '../../../global/layouts/defauft.layout.dart';
import '../../../models/wallet/transaction.model.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/widgets/gutter.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({Key? key}) : super(key: key);

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
              child: controller.transactionList.length > 0
                  ? ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.transactionList.length,
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
            ),
          ),
        );
      },
    );
  }
}
