import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/layouts/defauft.layout.dart';
import '../../../global/widgets/empty_file_widget.dart';
import 'package:intl/intl.dart';
import '../../../global/widgets/gutter.dart';

import '../../../global/themes/color.theme.dart';

class BonusHistoryScreen extends StatelessWidget {
  const BonusHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return DefaultLayout(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              brightness: Brightness.dark,
              backgroundColor: Colors.transparent,
              title: Text("Bonus History"),
              centerTitle: true,
            ),
            body: Container(
              color: Colors.white,
              child: controller.bonusList!.length > 0
                  ? ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.bonusList!.length,
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
                    )
                  : EmptyFileWidget(),
            ),
          ),
        );
      },
    );
  }
}
