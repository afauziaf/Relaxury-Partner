import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile.controller.dart';
import '../../../models/profile/commission_package.model.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';
import 'commission_confirmation.screen.dart';

class CommissionPackageListScreen extends StatelessWidget {
  const CommissionPackageListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
              gradient: new LinearGradient(colors: [
            Colors.red.shade300,
            Colors.red.shade400,
          ])),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              brightness: Brightness.dark,
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              title: Text(
                "Commission Packages",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              height: Get.height,
              color: Colors.white,
              child: ListView.separated(
                itemBuilder: (context, index) => AgencyBuyingCard(commissionPackageModel: controller.commissionPackageModel!),
                separatorBuilder: (context, index) => Gutter(),
                itemCount: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}

class AgencyBuyingCard extends StatelessWidget {
  const AgencyBuyingCard({
    Key? key,
    required this.commissionPackageModel,
  }) : super(key: key);

  final CommissionPackageModel commissionPackageModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(gutter),
      padding: EdgeInsets.all(gutter),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Get.theme.primaryColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: new LinearGradient(colors: [
                  Colors.red.shade300,
                  Colors.red.shade400,
                ]),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: EdgeInsets.all(gutter),
              child: Text(
                commissionPackageModel.name.capitalizeFirst.toString(),
                textAlign: TextAlign.center,
                style: Get.textTheme.headline4!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: gutter),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                "\$" + commissionPackageModel.amount.toStringAsFixed(0),
                style: Get.textTheme.headline2!.copyWith(fontWeight: FontWeight.bold, color: primaryColor),
              ),
              Text(" / " + commissionPackageModel.period.toString() + " " + commissionPackageModel.unit, style: Get.textTheme.headline6!.copyWith(fontWeight: FontWeight.normal))
            ],
          ),
          SizedBox(height: gutter),
          Container(
            decoration: BoxDecoration(
              gradient: new LinearGradient(colors: [
                Colors.red.shade300,
                Colors.red.shade400,
              ]),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: gutter),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: gutter * 2, vertical: gutter),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Enjoy more floors",
                            style: Get.textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: gutter),
                        Icon(Icons.check, color: Colors.white),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: gutter * 2, vertical: gutter),
                    color: Colors.black12,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Enjoy commissions when loaded",
                            style: Get.textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: gutter),
                        Icon(Icons.check, color: Colors.white),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: gutter * 2, vertical: gutter),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Get commissions when reffering friends",
                            style: Get.textTheme.bodyText1!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: gutter),
                        Icon(Icons.check, color: Colors.white),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: gutter, horizontal: gutter * 3),
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => CommissionConfirmationScreen(commissionPackageModel: commissionPackageModel)),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius),
                            // side: BorderSide(color: Get.theme.primaryColor, width: 2),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: SizedBox(
                        height: 48,
                        child: Center(
                          child: Text(
                            "BUY",
                            style: Get.textTheme.headline5!.copyWith(color: Get.theme.primaryColor, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
