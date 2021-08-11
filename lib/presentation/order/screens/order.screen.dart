import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../controllers/order.controller.dart';
import '../components/active_order.tab.dart';
import '../components/pending_order.tab.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderController _orderController = Get.find();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _orderController.getBookingOrder();
  }

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _orderController.getBookingOrder();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: new LinearGradient(colors: [
        Colors.red.shade300,
        Colors.red.shade400,
      ])),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              "Booking Order",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            brightness: Brightness.dark,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            bottom: TabBar(
              labelStyle: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: "Pending Order"),
                Tab(text: "Active Order"),
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
                physics: NeverScrollableScrollPhysics(),
                children: [
                  PendingOrderTab(),
                  ActiveOrderTab(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
