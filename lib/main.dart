import 'package:covid_nepal_tracker/controllers/connectivity_controller.dart';
import 'package:covid_nepal_tracker/handlers/routes/route_handler.dart';
import 'package:covid_nepal_tracker/handlers/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => ConnectivityController());
  runApp(const CovidNepalTrackerApp());
}

class CovidNepalTrackerApp extends StatelessWidget {
  const CovidNepalTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Covid Nepal - Tracker',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        appBarTheme: const AppBarTheme(
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
      ),
      navigatorKey: Get.key,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      onGenerateRoute: RoutesHandler.handleOnGenerateRoute,
    );
  }
}
