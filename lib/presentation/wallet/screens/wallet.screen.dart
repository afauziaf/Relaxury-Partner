import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/layouts/defauft.layout.dart';

import '../components/bonus.tab.dart';
import '../components/wallet.tab.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({
    Key? key,
  }) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            brightness: Brightness.dark,
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: Icon(Icons.web, color: Colors.transparent),
            title: Text(
              "Wallet",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            bottom: TabBar(
              labelStyle: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Agency'),
                Tab(text: 'Commission'),
              ],
            ),
          ),
          body: Container(
            color: Get.theme.scaffoldBackgroundColor,
            child: Column(
              children: [
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      WalletTab(),
                      BonusTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
