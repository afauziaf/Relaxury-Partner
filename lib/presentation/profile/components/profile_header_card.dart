import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/helpers/storage.dart';
import '../../../global/themes/color.theme.dart';
import '../screens/edit_profile.screen.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: padding * 6,
              child: Container(
                decoration: BoxDecoration(
                    gradient: new LinearGradient(colors: [
                  Colors.red.shade300,
                  Colors.red.shade400,
                ])),
              ),
            ),
            Card(
              elevation: 10,
              color: Colors.white,
              margin: EdgeInsets.all(padding),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () => Get.to(() => EditProfileScreen()),
                      icon: Icon(
                        Icons.edit,
                        size: 16,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: Hero(
                              tag: 'avatar',
                              child: controller.profileModel.avatar != null
                                  ? Image.network(
                                      Storage(StorageName.baseUrl).read() + (controller.profileModel.avatar ?? ""),
                                      fit: BoxFit.cover,
                                      height: Get.width * 0.25,
                                      width: Get.width * 0.25,
                                      errorBuilder: (context, object, stack) {
                                        return Image.asset(
                                          'assets/images/customer_avatar.png',
                                          height: Get.width * 0.25,
                                          width: Get.width * 0.25,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      'assets/images/customer_avatar.png',
                                      height: Get.width * 0.25,
                                      width: Get.width * 0.25,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        Gutter(),
                        Text(
                          controller.profileModel.username!,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
                        ),
                        // Gutter(),
                        Text(
                          "@" + controller.profileModel.email!.replaceAll('@gmail.com', ''),
                          textAlign: TextAlign.center,
                          style: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
