import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/config/config.dart';
import 'package:juno_getx_base_project/core/localization/localization.dart';
import 'package:juno_getx_base_project/core/routing/routing.dart';
import 'package:juno_getx_base_project/core/values/values.dart';
import 'package:logger/logger.dart';
import 'dependency_injection.dart' as di;

Future<void> mainCommon() async {
  final Logger logger = FlavorConfig.instance.logger;

  await runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      /// Load environmental .env to get the [API_URL]
      /// this is to create extra layer of security
      /// instead of hardcoding the API_URL, we store it in .env file
      await dotenv.load(fileName: Environment.fileName);

      // initialize dependency injection services
      await di.init();

      runApp(const MyApp());
    },
    (Object error, StackTrace stackTrace) {
      logger.e('Controller>>>>>> error $error');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: FlavorConfig.title,
      locale: Get.deviceLocale,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      translations: Apptranslations(),
      fallbackLocale: Apptranslations.fallbackLocale,
      theme: ThemeData(
        primarySwatch: AppColors.colorPrimarySwatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        primaryColor: AppColors.colorPrimary,
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        fontFamily: 'Roboto',
      ),
    );
  }
}
