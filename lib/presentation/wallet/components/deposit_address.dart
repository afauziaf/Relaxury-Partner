import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../global/helpers/snackbar.helper.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class DepositAddress extends StatelessWidget {
  const DepositAddress({
    Key? key,
    required this.address,
  }) : super(key: key);

  final String address;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: EdgeInsets.all(gutter),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Get.theme.primaryColor, width: 2),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: QrImage(
              data: address,
              version: QrVersions.auto,
            ),
          ),
          SizedBox(width: gutter),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/usdc.svg', width: 24, height: 24, color: Get.theme.primaryColor),
                      SizedBox(width: gutter),
                      Expanded(
                        child: Text(
                          "USD Coin (USDC)",
                          overflow: TextOverflow.ellipsis,
                          style: Get.textTheme.bodyText1!.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: gutter / 2),
                Container(
                  padding: EdgeInsets.all(gutter / 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            address,
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
                          Clipboard.setData(ClipboardData(text: "Hello World Hello World Hello World Hello World Hello World Hello World Hello World Hello World "));
                          AlertSnackbar.open(title: "Success", message: "Ref has been saved into clipboard", status: AlertType.success);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
