import 'package:covid_nepal_tracker/models/covid_case.dart';
import 'package:flutter/foundation.dart';

/// Isolate function to parse covid cases json data
Future<List<CovidCase>?> parseCovidCasesJsonData(dynamic data) async {
  try {
    final temp = List<CovidCase>.empty(growable: true);
    for (final json in data) {
      temp.add(CovidCase.fromJson(json));
    }

    if (temp.isNotEmpty) {
      return temp;
    }
    return null;
  } catch (e) {
    if (kDebugMode) {
      print("[parseCovidCasesJsonData] ---> ${e.toString()}");
    }
    return null;
  }
}
