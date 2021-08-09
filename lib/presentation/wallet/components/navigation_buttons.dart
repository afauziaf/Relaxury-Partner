import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/themes/layout.theme.dart';
import '../screens/convert.screen.dart';
import '../screens/transfer.screen.dart';
import '../screens/withdraw.screen.dart';
import '../widgets/navigate_icon_button.dart';

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(gutter),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(gutter),
        gradient: new LinearGradient(
          colors: [
            Colors.red.shade400,
            Colors.red.shade300,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavigateIconButton(
              onTap: () {
                Get.to(() => TransferScreen());
              },
              iconPath: 'assets/icons/transfer.svg',
              label: "Transfer"),
          NavigateIconButton(
              onTap: () {
                Get.to(() => ConvertScreen());
              },
              iconPath: 'assets/icons/convert.svg',
              label: "Convert"),
          NavigateIconButton(
            onTap: () {
              Get.to(() => WithdrawScreen());
            },
            iconPath: 'assets/icons/withdraw.svg',
            label: "Withdraw",
          ),
        ],
      ),
    );
  }
}
