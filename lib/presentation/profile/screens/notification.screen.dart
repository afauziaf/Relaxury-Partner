import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../controllers/notification.controller.dart';
import '../../../global/layouts/defauft.layout.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/widgets/gutter.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController _notificationController = Get.find();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await _notificationController.getNotificationList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
      builder: (controller) {
        return DefaultLayout(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              title: Text("Notification"),
              centerTitle: true,
            ),
            body: SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: Container(
                color: Colors.white,
                height: double.infinity,
                child: controller.notificationList.length > 0
                    ? SingleChildScrollView(
                        child: ListView.separated(
                          padding: EdgeInsets.all(gutter),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: controller.notificationList.length,
                          itemBuilder: (context, index) {
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
                                  child: SvgPicture.asset('assets/icons/bell.svg'),
                                ),
                                title: Text(
                                  controller.notificationList[index].title,
                                  style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  controller.notificationList[index].content,
                                  style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => Gutter(),
                        ),
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
