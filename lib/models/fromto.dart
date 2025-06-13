class LocationModel {
  String? name;
  String? lat;
  String? lon;

  LocationModel({this.name, this.lat, this.lon});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String?,
      lat: json['lat'] as String?,
      lon: json['lon'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
    };
  }
}