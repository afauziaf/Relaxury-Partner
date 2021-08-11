import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../controllers/profile.controller.dart';
import '../../../global/helpers/snackbar.helper.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class AgencyTab extends StatelessWidget {
  const AgencyTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Card(
          margin: const EdgeInsets.all(padding),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(padding)),
          child: Container(
            padding: EdgeInsets.all(padding),
            decoration: BoxDecoration(
              gradient: new LinearGradient(
                colors: [
                  Colors.red.shade300,
                  Colors.red.shade400,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Package Name
                Text(
                  controller.commissionPackageModel!.name.capitalizeFirst.toString(),
                  textAlign: TextAlign.center,
                  style: Get.textTheme.headline5!.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),

                Divider(color: Colors.white),

                // Refferal Link
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.all(gutter),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(borderRadius),
                        color: Colors.white,
                      ),
                      child: QrImage(
                        data: controller.profileModel.ref!,
                        version: QrVersions.auto,
                      ),
                    ),
                    Gutter(),
                    Container(
                      padding: EdgeInsets.all(gutter / 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                controller.profileModel.ref!,
                                maxLines: 1,
                              ),
                            ),
                          ),
                          Gutter(scale: 0.5),
                          GFIconButton(
                            icon: Icon(
                              Icons.copy,
                              color: Colors.white,
                            ),
                            size: GFSize.SMALL,
                            color: primaryColor,
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: controller.profileModel.ref));
                              AlertSnackbar.open(title: "Success", message: "Ref has been saved into clipboard", status: AlertType.success);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                Divider(color: Colors.white),

                // Package Infomation
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Start Day", style: Get.textTheme.bodyText1!.copyWith(color: Colors.white)),
                        Text(DateFormat('dd/MM/yyyy').format(controller.commissionModel!.createdAt), style: Get.textTheme.bodyText1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Gutter(scale: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("End Day", style: Get.textTheme.bodyText1!.copyWith(color: Colors.white)),
                        Text(DateFormat('dd/MM/yyyy').format(controller.commissionModel!.dateEnd), style: Get.textTheme.bodyText1!.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
