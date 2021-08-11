import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';

import '../../../controllers/auth.controller.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';
import '../layout/auth.layout.dart';

class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({Key? key}) : super(key: key);

  @override
  _AccountVerificationScreenState createState() => _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  AuthController _authController = Get.find();
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();
  TextEditingController _emailInputController = new TextEditingController();
  String email = '';

  @override
  void initState() {
    super.initState();

    print(Get.arguments.toString());

    if (Get.arguments != null) {
      _emailInputController.text = Get.arguments;
      email = Get.arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
        title: "Account Verification",
        subtitle: "Enter the code and email to verify your account",
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                children: [
                  // Email
                  if (Get.arguments == null)
                    Row(
                      children: [
                        Expanded(
                          child: FormBuilderTextField(
                            name: "email",
                            controller: _emailInputController,
                            cursorColor: primaryColor,
                            keyboardType: TextInputType.emailAddress,
                            decoration: inputDecoration.copyWith(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value) {
                              if (value != null && value.length > 0) {
                                if (value.toString().isEmail) {
                                  return null;
                                } else {
                                  return "Email is invalid";
                                }
                              } else {
                                return "Email is required";
                              }
                            },
                          ),
                        ),
                        Gutter(),
                        GFButton(
                          onPressed: () => _authController.sendCodeWithEmail(email: _emailInputController.text.trim()),
                          text: "Get Code",
                          size: GFSize.LARGE,
                          color: primaryColor,
                          textColor: Colors.white,
                        ),
                      ],
                    ),

                  if (Get.arguments == null) Gutter(), if (Get.arguments == null) Divider(), if (Get.arguments == null) Gutter(),

                  // Code
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

                        _authController.accountVerification(
                          email: Get.arguments == null ? _formKey.currentState!.fields['code']!.value.toString().trim() : Get.arguments,
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
        ));
  }
}
