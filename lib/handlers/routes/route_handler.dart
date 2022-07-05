import 'package:covid_nepal_tracker/controllers/covid_case_controller.dart';
import 'package:covid_nepal_tracker/handlers/routes/routes.dart';
import 'package:covid_nepal_tracker/pages/home/home_page.dart';
import 'package:covid_nepal_tracker/pages/page_not_found/not_found_page.dart';
import 'package:covid_nepal_tracker/pages/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RoutesHandler {
  ///--------------------------------@mit------------------------------
  /// method to handle onGenerateRoute
  static Route<dynamic> handleOnGenerateRoute(RouteSettings settings) {
    return _getPageRoute(settings);
  }

  ///--------------------------------@mit------------------------------
  /// Method to return GetPageRoute by parsing route
  static Route<dynamic> _getPageRoute(RouteSettings settings) {
    Route<dynamic> pageRoute;

    switch (settings.name) {
      case Routes.splash:
        pageRoute = GetPageRoute(
          page: () => const SplashPage(),
          settings: settings,
        );
        break;
      case Routes.home:
        pageRoute = GetPageRoute(
          page: () => const HomePage(),
          settings: settings,
          binding: BindingsBuilder(() {
            Get.lazyPut<CovidCaseController>(() => CovidCaseController());
          }),
        );
        break;
      default:
        pageRoute = GetPageRoute(
          page: () => const PageNotFound(),
          settings: settings,
          transition: Transition.zoom,
        );
    }
    return pageRoute;
  }

  ///--------------------------------@mit------------------------------
  /// Method to return the get pages
  static List<GetPage<dynamic>> get routePages => [
        GetPage(
          name: Routes.splash,
          page: () => const SplashPage(),
        ),
        GetPage(
          name: Routes.home,
          page: () => const HomePage(),
          binding: BindingsBuilder(
            () {
              Get.lazyPut<CovidCaseController>(() => CovidCaseController());
            },
          ),
        ),
      ];
}
