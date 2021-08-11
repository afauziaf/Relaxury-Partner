import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controllers/order.controller.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/layouts/defauft.layout.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/widgets/gutter.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderController _orderController = Get.find();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await _orderController.getBookingOrder();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (controller) {
        return DefaultLayout(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              title: Text("Order History"),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.white,
              height: double.infinity,
              child: controller.bookingHistory.length > 0
                  ? SmartRefresher(
                      enablePullDown: true,
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.all(gutter),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.bookingHistory.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                leading: Container(
                                    width: 40,
                                    height: 40,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: primaryColor,
                                    ),
                                    child: Image.asset(
                                      'assets/images/customer_avatar.png',
                                      height: 24,
                                      width: 24,
                                      fit: BoxFit.cover,
                                    )),
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.bookingHistory[index].usernameUserBuy ?? "",
                                      style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Gutter(),
                                    Text(
                                      controller.bookingHistory[index].status == 2 ? "Completed" : "Canceled",
                                      style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: primaryColor),
                                    ),
                                  ],
                                ),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$ " + controller.bookingHistory[index].price.toString(),
                                      style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: primaryColor),
                                    ),
                                    Gutter(),
                                    Text(
                                      DateFormat('dd/MM/yyyy').format(controller.bookingHistory[index].dateFrom!),
                                      maxLines: 1,
                                      style: Get.textTheme.bodyText2!.copyWith(color: Colors.grey),
                                    )
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
