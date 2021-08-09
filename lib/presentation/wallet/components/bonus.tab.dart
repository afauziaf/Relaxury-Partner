import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controllers/profile.controller.dart';
import '../../../controllers/wallet.controller.dart';
import '../../../global/widgets/empty_file_widget.dart';
import 'wallet_balance.dart';
import 'package:intl/intl.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';
import '../screens/bonus_history.screen.dart';

class BonusTab extends StatefulWidget {
  const BonusTab({
    Key? key,
  }) : super(key: key);

  @override
  _BonusTabState createState() => _BonusTabState();
}

class _BonusTabState extends State<BonusTab> {
  WalletController _walletController = Get.find();
  ProfileController _profileController = Get.find();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await _walletController.getTransactionList();
    await _profileController.getProfileInfo();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: _profileController.profileModel.isBuyPackageCommission == 1
              ? GetBuilder<WalletController>(
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
                            title: 'Commission Balance',
                            balance: controller.walletModel.balanceCommission ?? 0,
                          ),
                          Gutter(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recent Comission",
                                textAlign: TextAlign.start,
                                style: Get.textTheme.headline6!.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                child: Center(
                                  child: IconButton(
                                    onPressed: () => Get.to(() => BonusHistoryScreen()),
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
                          GetBuilder<ProfileController>(
                            builder: (profileController) => profileController.bonusList!.length > 0
                                ? ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: profileController.bonusList!.length > 10 ? 10 : profileController.bonusList!.length,
                                    itemBuilder: (context, index) => Card(
                                      margin: EdgeInsets.all(0),
                                      child: ListTile(
                                        leading: Container(
                                          width: 40,
                                          height: 40,
                                          child: SvgPicture.asset('assets/icons/comission.svg'),
                                        ),
                                        title: Text(
                                          profileController.bonusList![index].name,
                                          style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          DateFormat('dd/MM/yyyy').format(profileController.bonusList![index].createdAt),
                                          maxLines: 1,
                                          style: Get.textTheme.bodyText2!.copyWith(color: Colors.grey),
                                        ),
                                        trailing: Text(profileController.bonusList![index].amount.toStringAsFixed(2) + " \$", style: Get.textTheme.bodyText1!.copyWith(color: primaryColor, fontWeight: FontWeight.bold)),
                                      ),
                                    ),
                                    separatorBuilder: (context, index) => Gutter(),
                                  )
                                : EmptyFileWidget(),
                          )
                        ],
                      ),
                    );
                  },
                )
              : Container(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/comission.svg',
                        height: 128,
                        width: 128,
                      ),
                      Gutter(),
                      Text("You have to buy Commission Package to be able to access", textAlign: TextAlign.center, style: Get.textTheme.headline6),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
