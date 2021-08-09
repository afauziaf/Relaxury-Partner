import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/size/gf_size.dart';
import '../../../controllers/wallet.controller.dart';
import '../../../global/layouts/functionality.layout.dart';

import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  WalletController _walletController = Get.find();
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return FunctionalityLayout(
      title: "Tranfer",
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: padding,
          bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? MediaQuery.of(context).viewInsets.bottom : padding,
          left: padding,
          right: padding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Form
            FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // New Password
                  FormBuilderTextField(
                    name: "username",
                    cursorColor: primaryColor,
                    decoration: inputDecoration.copyWith(
                      hintText: "Username",
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value != null && value.length > 0) {
                        return null;
                      } else {
                        return "Username is required";
                      }
                    },
                  ),

                  Gutter(scale: 2),

                  Text(
                    "Total: " + (_walletController.walletModel.balance ?? 0).toStringAsFixed(2),
                    textAlign: TextAlign.justify,
                  ),
                  Gutter(scale: 0.5),

                  // New Password Confirmation
                  FormBuilderTextField(
                    name: "amount",
                    cursorColor: primaryColor,
                    keyboardType: TextInputType.number,
                    decoration: inputDecoration.copyWith(
                      hintText: "Amount",
                      prefixIcon: Icon(Icons.paid),
                    ),
                    validator: (value) {
                      if (value != null && value.length > 0) {
                        if (value.toString().isNumericOnly) {
                          if (double.parse(value.toString()) > 0) {
                            return null;
                          } else {
                            return "Amount must greater than 0";
                          }
                        } else {
                          return "Amount must be a number";
                        }
                      } else {
                        return "Amount is required";
                      }
                    },
                  ),

                  Gutter(scale: 2),

                  // Code
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: "code",
                          cursorColor: primaryColor,
                          keyboardType: TextInputType.number,
                          decoration: inputDecoration.copyWith(
                            hintText: "Code",
                            prefixIcon: Icon(Icons.email),
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
                      GFIconButton(
                        onPressed: () => _walletController.sendCode(),
                        icon: Icon(Icons.send, size: 24),
                        borderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                        color: primaryColor,
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
                    onPressed: () {
                      final validationSuccess = _formKey.currentState!.validate();

                      if (validationSuccess) {
                        _formKey.currentState!.save();

                        _walletController.transfer(
                          username: _formKey.currentState!.fields['username']!.value,
                          amount: double.parse(_formKey.currentState!.fields['amount']!.value),
                          code: _formKey.currentState!.fields['code']!.value,
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
