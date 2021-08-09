import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:relaxury_partner/presentation/profile/screens/partner.screen.dart';
import 'package:relaxury_partner/presentation/profile/screens/partner_register.screen.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../components/profile_header_card.dart';
import 'comission_package_list.screen.dart';
import 'commission.screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController _profileController = Get.find();
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    await _profileController.getProfileInfo();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.loadComplete();
  }

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
              title: Text(
                "Profile",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SmartRefresher(
              enablePullDown: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: Container(
                height: Get.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ProfileHeaderCard(),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: padding),
                        children: [
                          // Commission
                          Card(
                            child: ListTile(
                              onTap: () {
                                if (controller.profileModel.hasProduct == 0)
                                  Get.to(() => PartnerRegisterScreen());
                                else
                                  Get.to(() => PartnerScreen());
                              },
                              leading: SizedBox(height: 36, width: 36, child: SvgPicture.asset('assets/icons/pages/partner.svg')),
                              title: Text("Partner", style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)),
                            ),
                          ),

                          // Commission
                          Card(
                            child: ListTile(
                              onTap: () {
                                if (controller.profileModel.isBuyPackageCommission == 0)
                                  Get.to(() => CommissionPackageListScreen());
                                else
                                  Get.to(() => CommissionScreen());
                              },
                              leading: SizedBox(height: 36, width: 36, child: SvgPicture.asset('assets/icons/comission.svg')),
                              title: Text("Commission", style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold)),
                            ),
                          ),

                          // Logout
                          Card(
                            color: primaryColor,
                            child: ListTile(
                              onTap: () => controller.logout(),
                              leading: Container(height: 36, width: 36, clipBehavior: Clip.hardEdge, padding: EdgeInsets.all(5), decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white), child: Icon(Icons.logout)),
                              title: Text("Log out", style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
