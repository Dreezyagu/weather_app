// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WeatherModel {
  final num? id;
  final String? main;
  final String? description;
  final String? icon;

  WeatherModel(this.id, this.main, this.description, this.icon);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      map['id'] != null ? map['id'] as num : null,
      map['main'] != null ? map['main'] as String : null,
      map['description'] != null ? map['description'] as String : null,
      map['icon'] != null ? map['icon'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(id: $id, main: $main, description: $description, icon: $icon)';
  }
}
