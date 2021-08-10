import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/splash.controller.dart';
import '../../global/themes/layout.theme.dart';
import '../../global/widgets/gutter.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(padding),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              Gutter(),
              Text(
                "Relaxury",
                style: Get.textTheme.headline4!.copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
