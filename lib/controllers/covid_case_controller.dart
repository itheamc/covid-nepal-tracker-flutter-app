import 'package:covid_nepal_tracker/models/covid_case.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../handlers/networking/network_response.dart';
import '../handlers/networking/request_handler.dart';
import '../handlers/networking/urls.dart';
import '../utils/json_parser.dart';


///--------------------------------@mit------------------------------
/// Controller for covid case
class CovidCaseController extends GetxController {
  NetworkResponse? _networkResponse;
  final _covidCases = List<CovidCase>.empty(growable: true).obs;

  NetworkResponse? get networkResponse => _networkResponse;

  List<CovidCase> get covidCases => _covidCases;

  final _fetchingCovidCases = NetworkRequestStatus.none.obs;

  bool get fetchingCovidCases =>
      _fetchingCovidCases.value == NetworkRequestStatus.requesting;

  bool get covidCaseFetchedSuccess =>
      _networkResponse != null && _networkResponse!.isSuccess;

  /// Method to get stores from the server
  Future<void> fetchCovidCases(String country) async {
    if (fetchingCovidCases) {
      return;
    }

    _networkResponse = null;
    _fetchingCovidCases.value = NetworkRequestStatus.requesting;

    final response = await RequestHandler.get(Urls.caseEndPoint(country));
    _networkResponse = response;

    if (covidCaseFetchedSuccess) {
      if (_networkResponse!.hasData &&
          _networkResponse!.data! is List &&
          _networkResponse!.data!.isNotEmpty) {
        final list = await compute<dynamic, List<CovidCase>?>(
            parseCovidCasesJsonData, _networkResponse!.data!);
        if (list != null) {
          _covidCases.value = list;
        }
      }
    }

    _fetchingCovidCases.value = NetworkRequestStatus.completed;
  }
}
