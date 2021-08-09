import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../controllers/notification.controller.dart';
import '../../../global/layouts/defauft.layout.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/widgets/gutter.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

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
            body: Container(
              color: Colors.white,
              child: controller.notificationList.length > 0
                  ? ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
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
                    )
                  : EmptyFileWidget(),
            ),
          ),
        );
      },
    );
  }
}
