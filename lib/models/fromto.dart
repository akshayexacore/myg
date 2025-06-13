class LocationModel {
  String? name;
  String? lat;
  String? lon;
  double? disatnce;

  LocationModel({this.name, this.lat, this.lon,this.disatnce});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      name: json['name'] as String?,
      lat: json['lat'] as String?,
      lon: json['lon'] as String?,
      disatnce: json['distance_km'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': lat,
      'lon': lon,
      'distance_km':disatnce
    };
  }
}