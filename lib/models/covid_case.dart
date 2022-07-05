class CovidCase {
  final String? id;
  final String? country;
  final String? countryCode;
  final double? lat;
  final double? lng;
  final num? confirmed;
  final num? recovered;
  final num? deaths;
  final num? active;

  CovidCase({
    this.id,
    this.country,
    this.countryCode,
    this.lat,
    this.lng,
    this.confirmed,
    this.recovered,
    this.deaths,
    this.active,
  });

  factory CovidCase.fromJson(Map<String, dynamic> json) {
    return CovidCase(
      id: json["ID"],
      country: json["Country"],
      countryCode: json["CountryCode"],
      lat: json["Lat"] != null ? double.tryParse(json["Lat"]) : null,
      lng: json["Lon"] != null ? double.tryParse(json["Lon"]) : null,
      confirmed: json["Confirmed"],
      recovered: json["Recovered"],
      deaths: json["Deaths"],
      active: json["Active"],
    );
  }
}
