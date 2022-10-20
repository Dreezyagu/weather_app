// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CitiesModel {
  final int id;
  final String? city;
  final String? lat;
  final String? lng;

  CitiesModel({this.city, this.lat, this.lng, required this.id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'city': city, 'lat': lat, 'lng': lng, 'id': id};
  }

  factory CitiesModel.fromMap(Map<String, dynamic> map) {
    return CitiesModel(
      city: map['city'] != null ? map['city'] as String : null,
      lat: map['lat'] != null ? map['lat'] as String : null,
      lng: map['lng'] != null ? map['lng'] as String : null,
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CitiesModel.fromJson(String source) =>
      CitiesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CitiesModel(id: $id, city: $city, lat: $lat, lng: $lng)';
  }
}
