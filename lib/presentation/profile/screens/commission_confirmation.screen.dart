import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../../controllers/profile.controller.dart';
import '../../../global/layouts/functionality.layout.dart';
import '../../../models/profile/commission_package.model.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class CommissionConfirmationScreen extends StatefulWidget {
  const CommissionConfirmationScreen({Key? key, required this.commissionPackageModel}) : super(key: key);

  final CommissionPackageModel commissionPackageModel;

  @override
  _CommissionConfirmationScreenState createState() => _CommissionConfirmationScreenState();
}

class _CommissionConfirmationScreenState extends State<CommissionConfirmationScreen> {
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();
  ProfileController _profileController = Get.find();
  TextEditingController _codeInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FunctionalityLayout(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(padding),
        child: Column(
          children: [
            Text(
              "Are you sure you want to buy this\n" + widget.commissionPackageModel.name.capitalizeFirst.toString() + " Package?",
              textAlign: TextAlign.center,
              style: Get.textTheme.bodyText1!.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            Gutter(),
            Text(
              "Fee: \$" + widget.commissionPackageModel.amount.toString(),
              textAlign: TextAlign.center,
              style: Get.textTheme.headline2!.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
            ),
            Gutter(),
            // Code
            FormBuilder(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      controller: _codeInputController,
                      name: "code",
                      keyboardType: TextInputType.number,
                      cursorColor: primaryColor,
                      decoration: inputDecoration.copyWith(
                        hintText: "Code",
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Gutter(),
                  GFIconButton(
                    onPressed: () async {
                      await _profileController.sendCode();
                    },
                    color: Colors.grey.shade200,
                    icon: Icon(
                      Icons.send,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Gutter(),
            GFButton(
              fullWidthButton: true,
              onPressed: () {
                final validationSuccess = _formKey.currentState!.validate();

                if (validationSuccess) {
                  _formKey.currentState!.save();
                  _profileController.buyCommissionPackage(packageId: widget.commissionPackageModel.id, code: _codeInputController.text);
                }
              },
              text: "Accept",
              size: GFSize.LARGE,
              borderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
              textStyle: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
              color: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
