import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controllers/profile.controller.dart';
import '../../../controllers/wallet.controller.dart';
import '../components/agency.tab.dart';
import '../components/commission_tree.tab.dart';

class CommissionScreen extends StatefulWidget {
  const CommissionScreen({Key? key}) : super(key: key);

  @override
  _CommissionScreenState createState() => _CommissionScreenState();
}

class _CommissionScreenState extends State<CommissionScreen> {
  ProfileController _profileController = Get.find();
  WalletController _walletController = Get.find();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _profileController.getProfileInfo();
    _walletController.getWalletInfo();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _profileController.getProfileInfo();
    _walletController.getWalletInfo();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return DefaultTabController(
          length: 2,
          child: Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(colors: [
              Colors.red.shade300,
              Colors.red.shade400,
            ])),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                brightness: Brightness.dark,
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
                title: Text(
                  controller.commissionPackageModel!.name.capitalizeFirst.toString(),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                bottom: TabBar(
                  labelStyle: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(text: "Agency"),
                    Tab(text: "Commisison Tree"),
                  ],
                ),
              ),
              body: SmartRefresher(
                enablePullDown: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: Container(
                  color: Colors.white,
                  child: TabBarView(
                    children: [
                      AgencyTab(),
                      CommissionTreeTab(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
