import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controllers/wallet.controller.dart';

import '../../../controllers/profile.controller.dart';
import '../../../global/layouts/defauft.layout.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/widgets/gutter.dart';

class BonusHistoryScreen extends StatefulWidget {
  const BonusHistoryScreen({Key? key}) : super(key: key);

  @override
  _BonusHistoryScreenState createState() => _BonusHistoryScreenState();
}

class _BonusHistoryScreenState extends State<BonusHistoryScreen> {
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
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return DefaultLayout(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              title: Text("Bonus History"),
              centerTitle: true,
            ),
            body: Container(
              height: double.infinity,
              color: Colors.white,
              child: controller.bonusList!.length > 0
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
                          itemCount: controller.bonusList!.length,
                          itemBuilder: (context, index) => Card(
                            margin: EdgeInsets.all(0),
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                child: SvgPicture.asset('assets/icons/comission.svg'),
                              ),
                              title: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      controller.bonusList![index].name,
                                      maxLines: 1,
                                      style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Gutter(),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(controller.bonusList![index].createdAt),
                                    maxLines: 1,
                                    style: Get.textTheme.bodyText2!.copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                              subtitle: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      controller.bonusList![index].message,
                                      maxLines: 1,
                                      style: Get.textTheme.bodyText2!.copyWith(color: Colors.grey),
                                    ),
                                  ),
                                  Gutter(),
                                  Text(
                                    controller.bonusList![index].amount.toStringAsFixed(2) + " \$",
                                    style: Get.textTheme.bodyText1!.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
