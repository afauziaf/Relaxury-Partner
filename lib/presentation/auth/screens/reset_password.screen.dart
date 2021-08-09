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

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  AuthController _authController = Get.find();
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();
  TextEditingController _emailInputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Reset Password",
      subtitle: "Enter your mail to get the code and fill in your new password",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                // Email
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
                    GFIconButton(
                      onPressed: () => _authController.sendCodeWithEmail(email: _emailInputController.text.trim()),
                      icon: Icon(Icons.send, size: 24),
                      borderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                      color: primaryColor,
                    ),
                  ],
                ),

                Gutter(), Divider(), Gutter(),

                // New Password
                FormBuilderTextField(
                  name: "new_password",
                  cursorColor: primaryColor,
                  obscureText: true,
                  decoration: inputDecoration.copyWith(
                    hintText: "New Password",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value != null && value.length > 0) {
                      if (value.length >= 6) {
                        return null;
                      } else {
                        return "Password must be at least 6 characters";
                      }
                    } else {
                      return "Password is required";
                    }
                  },
                ),

                Gutter(),

                // New Password Confirmation
                FormBuilderTextField(
                  name: "new_password_confirmation",
                  cursorColor: primaryColor,
                  obscureText: true,
                  decoration: inputDecoration.copyWith(
                    hintText: "New Password Confirmation",
                    prefixIcon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value != null && value.length > 0) {
                      if (value.toString() == _formKey.currentState!.fields['new_password']!.value.toString()) {
                        return null;
                      } else {
                        return "Password doesn't match";
                      }
                    } else {
                      return "Password is required";
                    }
                  },
                ),

                Gutter(),

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
                      _authController.resetPassword(
                        password: _formKey.currentState!.fields['new_password']!.value.toString().trim(),
                        confirmPassword: _formKey.currentState!.fields['new_password_confirmation']!.value.toString().trim(),
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
    );
  }
}
