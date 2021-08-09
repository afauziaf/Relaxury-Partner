import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/widgets/gutter.dart';

class WalletBalance extends StatelessWidget {
  const WalletBalance({
    Key? key,
    required this.balance,
    required this.title,
  }) : super(key: key);

  final String title;
  final num balance;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.monetization_on, color: Colors.black),
            Gutter(),
            Text(title, style: Get.textTheme.bodyText1!.copyWith(color: Colors.black)),
          ],
        ),
        Text(
          "Point " + balance.toString(),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: Get.textTheme.headline4!.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
