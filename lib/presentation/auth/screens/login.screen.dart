import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import '../../../controllers/auth.controller.dart';
import '../../../global/routes/name.route.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/themes/layout.theme.dart';
import '../../../global/widgets/clickable_text.dart';
import '../../../global/widgets/gutter.dart';
import '../layout/auth.layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController _authController = Get.find();
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Login",
      subtitle: "Welcome to Relaxury Partner",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Login Form
          FormBuilder(
            key: _formKey,
            child: Column(
              children: [
                // Username
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

                Gutter(),

                // Password
                FormBuilderTextField(
                  name: "password",
                  cursorColor: primaryColor,
                  obscureText: !_showPassword,
                  decoration: inputDecoration.copyWith(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        _showPassword = !_showPassword;
                      }),
                      icon: Icon(_showPassword ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.length > 0) {
                      if (value.length >= 6) {
                        return null;
                      } else {
                        return "Password must be at least 6 characters length";
                      }
                    } else {
                      return "Password is required";
                    }
                  },
                ),
              ],
            ),
          ),

          Gutter(),

          // Forgot Password
          ClickableText(
            onTap: () => Get.toNamed(RouteName.resetPassword),
            text: Text(
              "Forgot password",
              style: Get.textTheme.bodyText1!.copyWith(color: primaryColor, fontWeight: FontWeight.bold),
            ),
          ),

          Gutter(scale: 2),

          // Function
          Row(
            children: [
              // Login
              Expanded(
                child: GFButton(
                  onPressed: () async {
                    final validationSuccess = _formKey.currentState!.validate();

                    if (validationSuccess) {
                      _formKey.currentState!.save();
                      _authController.login(
                        username: _formKey.currentState!.fields['username']!.value.toString().trim(),
                        password: _formKey.currentState!.fields['password']!.value.toString().trim(),
                      );
                    }
                  },
                  text: "Log In",
                  size: GFSize.LARGE,
                  borderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                  textStyle: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                  color: primaryColor,
                ),
              ),

              Gutter(),

              // Register
              Expanded(
                child: GFButton(
                  onPressed: () => Get.toNamed(RouteName.register),
                  text: "Sign Up",
                  size: GFSize.LARGE,
                  borderShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
                  textStyle: Get.textTheme.bodyText1!.copyWith(fontWeight: FontWeight.bold, color: Colors.grey),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
