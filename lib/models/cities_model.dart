import 'dart:convert';

class CitiesModel {
  final String? city;
  final String? lat;
  final String? lng;

  CitiesModel({
    this.city,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'lat': lat,
      'lng': lng,
    };
  }

  factory CitiesModel.fromMap(Map<String, dynamic> map) {
    return CitiesModel(
      city: map['city'] != null ? map['city'] as String : null,
      lat: map['lat'] != null ? map['lat'] as String : null,
      lng: map['lng'] != null ? map['lng'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CitiesModel.fromJson(String source) =>
      CitiesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CitiesModel( city: $city, lat: $lat, lng: $lng)';
  }
}
