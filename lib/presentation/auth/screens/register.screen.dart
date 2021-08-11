import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../../../controllers/auth.controller.dart';
import '../../../global/themes/layout.theme.dart';
import '../components/country_picker.bottomsheet.dart';
import '../layout/auth.layout.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../global/screens/qr_scanner.screen.dart';
import '../../../global/themes/color.theme.dart';
import '../../../global/themes/input.theme.dart';
import '../../../global/widgets/gutter.dart';
import '../../../services/country.service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool passShow = false;
  bool passConfShow = false;
  AuthController _authController = Get.find();
  GlobalKey<FormBuilderState> _formKey = new GlobalKey<FormBuilderState>();
  TextEditingController _refInputController = new TextEditingController();
  CountryModel _selectedCountry = new CountryModel(name: "Thailand", callingCodes: ["66"], nativeName: 'ประเทศไทย', flag: "https://restcountries.eu/data/tha.svg");

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      title: "Register",
      subtitle: "Fill in below field to register",
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Register Form
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

                // Phone
                Row(
                  children: [
                    GFIconButton(
                      onPressed: () async {
                        var data = await Get.bottomSheet<CountryModel>(CountryPickerBottomSheet());

                        if (data != null) {
                          setState(() {
                            _selectedCountry = data;
                          });
                        }
                      },
                      color: Colors.grey.shade200,
                      icon: SvgPicture.network(
                        _selectedCountry.flag,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    Gutter(),
                    Expanded(
                      child: FormBuilderTextField(
                        name: "phone",
                        cursorColor: primaryColor,
                        keyboardType: TextInputType.phone,
                        decoration: inputDecoration.copyWith(
                          hintText: "Phone",
                        ),
                        validator: (value) {
                          if (value != null && value.length > 0) {
                            if (value.toString().isPhoneNumber) {
                              return null;
                            } else {
                              return "Phone number is invalid";
                            }
                          } else {
                            return "Phone number is required";
                          }
                        },
                      ),
                    ),
                  ],
                ),

                Gutter(),

                // Email
                FormBuilderTextField(
                  name: "email",
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

                Gutter(),

                // Password
                FormBuilderTextField(
                  name: "password",
                  cursorColor: primaryColor,
                  obscureText: !passShow,
                  decoration: inputDecoration.copyWith(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        passShow = !passShow;
                      }),
                      icon: Icon(passShow ? Icons.visibility : Icons.visibility_off),
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
                Gutter(),

                // Password Confirmation
                FormBuilderTextField(
                  name: "password_confirmation",
                  cursorColor: primaryColor,
                  obscureText: !passConfShow,
                  decoration: inputDecoration.copyWith(
                    hintText: "Password Confirmation",
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () => setState(() {
                        passConfShow = !passConfShow;
                      }),
                      icon: Icon(passConfShow ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.length > 0) {
                      if (value.toString() == _formKey.currentState!.fields['password']!.value.toString()) {
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

                // Ref
                Row(
                  children: [
                    Expanded(
                      child: FormBuilderTextField(
                        controller: _refInputController,
                        name: "ref",
                        cursorColor: primaryColor,
                        decoration: inputDecoration.copyWith(
                          hintText: "Ref",
                          prefixIcon: Icon(Icons.link),
                        ),
                      ),
                    ),
                    Gutter(),
                    GFIconButton(
                      onPressed: () async {
                        Barcode? barcode = await Get.to(() => QrScannerScreen());

                        print("Hello World");

                        if (barcode != null) {
                          setState(() {
                            _refInputController.text = barcode.code;
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

                      _authController.register(
                        username: _formKey.currentState!.fields['username']!.value.toString().trim(),
                        phone: _formKey.currentState!.fields['phone']!.value.toString().trim(),
                        email: _formKey.currentState!.fields['email']!.value.toString().trim(),
                        password: _formKey.currentState!.fields['password']!.value.toString().trim(),
                        passwordConfirmation: _formKey.currentState!.fields['password_confirmation']!.value.toString().trim(),
                        refId: _refInputController.text,
                      );
                    }
                  },
                  text: "Sign up",
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
