import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NavigateIconButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final Function onTap;

  const NavigateIconButton({
    Key? key,
    required this.onTap,
    required this.iconPath,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        child: Column(
          children: [
            SvgPicture.asset(
              iconPath,
              height: 48,
              width: 48,
              color: Colors.white,
            ),
            SizedBox(height: 12),
            Text(
              label,
              style: Get.textTheme.bodyText2!.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
