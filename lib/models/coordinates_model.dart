// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CoordinatesModel {
  final num? lon;
  final num? lat;

  CoordinatesModel(this.lon, this.lat);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'lon': lon,
      'lat': lat,
    };
  }

  factory CoordinatesModel.fromMap(Map<String, dynamic> map) {
    return CoordinatesModel(
      map['lon'] != null ? map['lon'] as num : null,
      map['lat'] != null ? map['lat'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CoordinatesModel.fromJson(String source) =>
      CoordinatesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CoordinatesModel(lon: $lon, lat: $lat)';
}
