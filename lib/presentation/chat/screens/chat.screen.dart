import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../controllers/order.controller.dart';
import '../../../global/layouts/defauft.layout.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';

import '../../../global/widgets/gutter.dart';
import 'individual.screen..dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
        return DefaultLayout(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              brightness: Brightness.dark,
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(
                "Chat",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Container(
              height: double.infinity,
              color: Colors.white,
              child: SmartRefresher(
                enablePullDown: true,
                controller: _refreshController,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: controller.activeBookingOrder.length > 0
                    ? ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(gutter),
                        itemCount: controller.activeBookingOrder.length,
                        itemBuilder: (context, index) => Card(
                          margin: EdgeInsets.all(0),
                          elevation: 5,
                          child: ListTile(
                            onTap: () => Get.to(() => IndividualChatScreen(
                                  name: controller.activeBookingOrder[index].usernameUserBuy!,
                                  orderId: controller.activeBookingOrder[index].ordersId!,
                                )),
                            leading: Container(
                              height: 40,
                              width: 40,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(shape: BoxShape.circle),
                              child: Image.asset(
                                'assets/images/error_avatar.png',
                                height: 24,
                                width: 24,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              controller.activeBookingOrder[index].usernameUserBuy!,
                              style: Get.textTheme.bodyText1!.copyWith(color: Get.theme.primaryColor),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => Gutter(scale: 0.5),
                      )
                    : EmptyFileWidget(),
              ),
            ),
          ),
        );
      },
    );
  }
}
