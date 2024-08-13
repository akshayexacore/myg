class TripTypeResponse {
  late bool success;
  late String message;
  late List<TripType> tripTypes;

  TripTypeResponse({this.success = false, this.message = '', this.tripTypes = const []});

  TripTypeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    success = json['statusCode'] == 200;
    tripTypes = <TripType>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        tripTypes.add(TripType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = message;
    data['data'] = tripTypes.map((v) => v.toJson()).toList();
    return data;
  }
}

class TripType {
  late int id;
  late String name;

  TripType({this.id = 0,this.name = ''});

  TripType.fromJson(Map<String, dynamic> json) {
    id = json['triptype_id'];
    name = json['triptype_name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['triptype_id'] = this.id;
    data['triptype_name'] = this.name;
    return data;
  }


  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TripType &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
