import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';
import '../../auth/layout/auth.layout.dart';

class PartnerRegisterConfirmationScreen extends StatefulWidget {
  const PartnerRegisterConfirmationScreen({Key? key}) : super(key: key);

  @override
  _PartnerRegisterConfirmationScreenState createState() => _PartnerRegisterConfirmationScreenState();
}

class _PartnerRegisterConfirmationScreenState extends State<PartnerRegisterConfirmationScreen> {
  ProfileController _profileController = Get.find();
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Become a partner\nFEE: \$200",
      subtitle: "Do you want to become out partner?\n",
      content: SingleChildScrollView(
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  // Email
                  Row(
                    children: [
                      Expanded(
                        child: // Code
                            FormBuilderTextField(
                          name: "code",
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration.copyWith(
                            hintText: "Code",
                            prefixIcon: Icon(Icons.password),
                          ),
                          validator: (value) {
                            if (value != null && value.length > 0) {
                              if (value.length >= 6) {
                                return null;
                              } else {
                                return "Code must be at least 6 characters";
                              }
                            } else {
                              return "Code is required";
                            }
                          },
                        ),
                      ),
                      Gutter(),
                      GFButton(
                        onPressed: () => _profileController.sendCode(),
                        text: "Get Code",
                        size: GFSize.LARGE,
                        color: primaryColor,
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Gutter(scale: 2),

            // Function
            Row(
              children: [
                Expanded(
                  child: GFButton(
                    onPressed: () async {
                      final validationSuccess = _formKey.currentState!.validate();

                      if (validationSuccess) {
                        _formKey.currentState!.save();

                        _profileController.registerPartner(
                          nickname: _profileController.partnerModel.nickname,
                          genderId: _profileController.partnerModel.genderId,
                          birthday: _profileController.partnerModel.birthday,
                          height: _profileController.partnerModel.height,
                          weight: _profileController.partnerModel.weight,
                          bust: _profileController.partnerModel.bust,
                          waist: _profileController.partnerModel.waist,
                          hips: _profileController.partnerModel.hips,
                          serviceList: _profileController.partnerModel.serviceList,
                          provinceId: _profileController.partnerModel.provinceId,
                          wardIdList: _profileController.partnerModel.wardIdList,
                          galleryList: _profileController.partnerModel.gallery,
                          code: _formKey.currentState!.fields['code']!.value.toString().trim(),
                        );
                      }
                    },
                    text: "Submit",
                    size: GFSize.LARGE,
                    borderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                    textStyle: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
