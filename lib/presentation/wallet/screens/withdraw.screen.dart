import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/button/gf_icon_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../controllers/wallet.controller.dart';
import '../../../global/layouts/functionality.layout.dart';
import '../../../global/screens/qr_scanner.screen.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/gutter.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({Key? key}) : super(key: key);

  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();
  WalletController _walletController = Get.find();
  TextEditingController _outputAddressInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FunctionalityLayout(
      title: "Withdraw",
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: padding,
          bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? MediaQuery.of(context).viewInsets.bottom : padding,
          left: padding,
          right: padding,
        ),
        child: Column(
          children: [
            // Form
            FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          controller: _outputAddressInputController,
                          name: "output_address",
                          cursorColor: primaryColor,
                          decoration: inputDecoration.copyWith(
                            hintText: "Output Address",
                            prefixIcon: Icon(Icons.account_balance_wallet),
                          ),
                          validator: (value) {
                            if (value != null && value.length > 0) {
                              return null;
                            } else {
                              return "Output Address is required";
                            }
                          },
                        ),
                      ),
                      Gutter(),
                      GFIconButton(
                        onPressed: () async {
                          Barcode? barcode = await Get.to(() => QrScannerScreen());
                          if (barcode != null) {
                            setState(() {
                              _outputAddressInputController.text = barcode.code;
                            });
                          }
                        },
                        color: Colors.grey.shade200,
                        icon: Icon(
                          Icons.qr_code_scanner,
                          color: Colors.grey.shade600,
                        ),
                      )
                    ],
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
                      GFButton(
                        onPressed: () => _walletController.sendCode(),
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
                    onPressed: () {
                      final validationSuccess = _formKey.currentState!.validate();

                      if (validationSuccess) {
                        _formKey.currentState!.save();
                        _walletController.withdraw(
                          outputAddress: _formKey.currentState!.fields['output_address']!.value,
                          amount: double.parse(_formKey.currentState!.fields['amount']!.value),
                          code: _formKey.currentState!.fields['code']!.value,
                        );
                        // controller.login(
                        //   username: _formKey.currentState.fields['username'].value,
                        //   password: _formKey.currentState.fields['password'].value,
                        // );
                        // widget.submitButtonPressed();
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
