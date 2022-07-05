class Urls {
  static const String BASE_URL = "https://api.covid19api.com";

  static caseEndPoint(String country) =>
      "/live/country/${country.toLowerCase()}/status/confirmed/date/${DateTime.now().subtract(const Duration(days: 1))}";
}
