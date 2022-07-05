import 'package:covid_nepal_tracker/controllers/connectivity_controller.dart';
import 'package:covid_nepal_tracker/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/covid_case_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => ConnectivityController());
  Get.lazyPut(() => CovidCaseController());
  runApp(const CovidNepalTrackerApp());
}

class CovidNepalTrackerApp extends StatelessWidget {
  const CovidNepalTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purple,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}
