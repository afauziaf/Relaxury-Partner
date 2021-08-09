import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/empty_file_widget.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/widgets/gutter.dart';

class CommissionTreeTab extends StatelessWidget {
  const CommissionTreeTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        if (controller.bonusList!.length > 0) {
          return ListView.separated(
            padding: EdgeInsets.all(padding),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.bonusList!.length > 10 ? 10 : controller.bonusList!.length,
            itemBuilder: (context, index) => Card(
              margin: EdgeInsets.all(0),
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  child: SvgPicture.asset('assets/icons/comission.svg'),
                ),
                title: Text(
                  controller.bonusList![index].name,
                  style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  DateFormat('dd/MM/yyyy').format(controller.bonusList![index].createdAt),
                  maxLines: 1,
                  style: Get.textTheme.bodyText2!.copyWith(color: Colors.grey),
                ),
                trailing: Text(controller.bonusList![index].amount.toStringAsFixed(2) + " \$", style: Get.textTheme.bodyText1!.copyWith(color: primaryColor, fontWeight: FontWeight.bold)),
              ),
            ),
            separatorBuilder: (context, index) => Gutter(),
          );
        } else {
          return EmptyFileWidget();
        }
      },
    );
  }
}
