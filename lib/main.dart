import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'global/routes/name.route.dart';
import 'global/routes/pages.route.dart';
import 'global/themes/theme.dart';

Future<void> main() async {
  await GetStorage.init('RelaxuryPartner');

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Relaxury Partner',
      theme: lightTheme,
      initialRoute: RouteName.splash,
      getPages: RoutePage.pages,
    );
  }
}
