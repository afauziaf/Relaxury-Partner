import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/getwidget.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/helpers/storage.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();
  ProfileController _profileController = Get.find();
  TextEditingController _nicknameInput = new TextEditingController();
  TextEditingController _phoneInput = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nicknameInput.text = _profileController.profileModel.username ?? "";
    _phoneInput.text = _profileController.profileModel.phoneNumber ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: new LinearGradient(colors: [
        Colors.red.shade300,
        Colors.red.shade400,
      ])),
      child: GetBuilder<ProfileController>(
        builder: (controller) => Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back)),
            elevation: 0,
            backgroundColor: Colors.transparent,
            brightness: Brightness.dark,
            title: Text(
              "Edit Profile",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: Container(
            height: Get.height,
            color: Colors.white,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(gutter),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Edit Form
                  Card(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                    child: Padding(
                      padding: EdgeInsets.all(gutter),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Profile Header
                          Align(
                            alignment: Alignment.center,
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(gutter / 2),
                                  height: Get.width * 0.25,
                                  width: Get.width * 0.25,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(shape: BoxShape.circle),
                                  child: Hero(
                                    tag: 'avatar',
                                    child: controller.profileModel.avatar != null
                                        ? Image.network(
                                            Storage(StorageName.baseUrl).read() + (controller.profileModel.avatar ?? ""),
                                            fit: BoxFit.cover,
                                            height: 24,
                                            width: 24,
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
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                                    child: GFIconButton(
                                      color: Colors.grey.shade200,
                                      icon: Icon(Icons.add_a_photo, color: primaryColor),
                                      size: GFSize.SMALL,
                                      shape: GFIconButtonShape.circle,
                                      onPressed: () async {
                                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: ['jpg', 'png'],
                                        );

                                        if (result != null) {
                                          controller.editAvatar(File(result.files.single.path!));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Divider(height: gutter * 2),

                          // Form
                          FormBuilder(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Username
                                FormBuilderTextField(
                                  controller: _nicknameInput,
                                  name: "nickname",
                                  cursorColor: primaryColor,
                                  decoration: inputDecoration.copyWith(
                                    hintText: "Nickname",
                                    prefixIcon: Icon(Icons.person),
                                  ),
                                ),

                                Gutter(),

                                // Phone
                                Row(
                                  children: [
                                    Expanded(
                                      child: FormBuilderTextField(
                                        controller: _phoneInput,
                                        name: "phone_number",
                                        cursorColor: primaryColor,
                                        decoration: inputDecoration.copyWith(
                                          prefixIcon: Icon(Icons.phone),
                                          hintText: "Phone Number",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Gutter(),

                                // Email
                                FormBuilderTextField(
                                  name: "email",
                                  cursorColor: primaryColor,
                                  readOnly: true,
                                  decoration: inputDecoration.copyWith(
                                    hintText: "Email",
                                  ),
                                  initialValue: controller.profileModel.email,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ),
                  ),

                  Gutter(),

                  // Save Button
                  GFButton(
                    onPressed: () {
                      controller.updateProfile(
                        username: _nicknameInput.text,
                        phone: _phoneInput.text,
                      );
                    },
                    text: "Save Profile",
                    size: GFSize.LARGE,
                    elevation: 5,
                    borderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                    textStyle: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                    color: primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
