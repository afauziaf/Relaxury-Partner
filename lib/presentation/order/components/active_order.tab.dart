import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controllers/order.controller.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/widgets/gutter.dart';
import 'package:intl/intl.dart';

class ActiveOrderTab extends StatefulWidget {
  ActiveOrderTab({Key? key}) : super(key: key);

  @override
  _ActiveOrderTabState createState() => _ActiveOrderTabState();
}

class _ActiveOrderTabState extends State<ActiveOrderTab> {
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
    return GetBuilder<OrderController>(
      builder: (controller) {
        if (controller.activeBookingOrder.isNotEmpty) {
          return SmartRefresher(
            enablePullDown: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: SingleChildScrollView(
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.all(gutter),
                itemCount: controller.activeBookingOrder.length,
                itemBuilder: (c, index) => Card(
                  margin: EdgeInsets.all(0),
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(gutter),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("# " + controller.activeBookingOrder[index].ordersId.toString(), style: Get.textTheme.bodyText1),
                        Row(
                          children: [
                            Text("Order by: ", style: Get.textTheme.bodyText1),
                            Spacer(),
                            Text(controller.activeBookingOrder[index].usernameUserBuy.toString(), style: Get.textTheme.bodyText1!.copyWith(color: Get.theme.primaryColor, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Divider(thickness: 1),
                        Row(
                          children: [
                            Icon(Icons.access_time),
                            Gutter(scale: 0.5),
                            Text("Start Time: ", style: Get.textTheme.bodyText1),
                            Spacer(),
                            Text(
                              DateFormat("dd/MM/yyyy - HH:mm").format(controller.activeBookingOrder[index].dateFrom!).toString(),
                              style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        if (controller.activeBookingOrder[index].skillId == 3) Gutter(),
                        if (controller.activeBookingOrder[index].skillId == 3)
                          Row(
                            children: [
                              Icon(Icons.calendar_today),
                              Gutter(scale: 0.5),
                              Text("End Time: ", style: Get.textTheme.bodyText1),
                              Spacer(),
                              Text(
                                DateFormat("dd/MM/yyyy - HH:mm").format(controller.activeBookingOrder[index].dateTo!).toString(),
                                style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        Gutter(),
                        Row(
                          children: [
                            Icon(Icons.dashboard),
                            Gutter(scale: 0.5),
                            Text("Service: ", style: Get.textTheme.bodyText1),
                            Spacer(),
                            Text(
                              (controller.activeBookingOrder[index].skillName).toString(),
                              // controllerprofileController.serviceList.where((element) => element.id == controller.activeBookingOrder[index].skillId).first.name.toString(),
                              style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Gutter(),
                        Row(
                          children: [
                            Icon(Icons.attach_money),
                            Gutter(scale: 0.5),
                            Text("Total Price: ", style: Get.textTheme.bodyText1),
                            Spacer(),
                            Text(
                              "\$ " + controller.activeBookingOrder[index].price!.toStringAsFixed(2),
                              style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Divider(thickness: 1),
                        if (controller.activeBookingOrder[index].note != null) Text("Note: ", style: Get.textTheme.bodyText1),
                        if (controller.activeBookingOrder[index].note != null) Gutter(scale: 0.5),
                        if (controller.activeBookingOrder[index].note != null) Text((controller.activeBookingOrder[index].note ?? "").toString(), style: Get.textTheme.bodyText1!.copyWith(color: Colors.grey)),
                        if (controller.activeBookingOrder[index].note != null) Divider(thickness: 1),
                        Row(
                          children: [
                            Expanded(
                              child: GFButton(
                                color: Colors.red,
                                onPressed: () => controller.cancelOrder(controller.activeBookingOrder[index].ordersId!),
                                text: "Cancel",
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Expanded(child: SizedBox()),
                            // Expanded(
                            //   child: GFButton(
                            //     color: Colors.green,
                            //     onPressed: () => controller.acceptOrder(controller.activeBookingOrder[index].ordersId),
                            //     text: "Accept",
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                separatorBuilder: (c, i) => Gutter(),
              ),
            ),
          );
        } else {
          return EmptyFileWidget();
        }
      },
    );
  }
}
