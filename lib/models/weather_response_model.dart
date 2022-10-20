// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:weather_app/models/coordinates_model.dart';
import 'package:weather_app/models/temperature_model.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherResponseModel {
  final CoordinatesModel coord;
  final List<WeatherModel> weather;
  final TemperatureModel main;

  WeatherResponseModel(this.coord, this.weather, this.main);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'coord': coord.toMap(),
      'weather': weather.map((x) => x.toMap()).toList(),
      'main': main.toMap(),
    };
  }

  factory WeatherResponseModel.fromMap(Map<String, dynamic> map) {
    return WeatherResponseModel(
      CoordinatesModel.fromMap(map['coord'] as Map<String, dynamic>),
      List<WeatherModel>.from(
        (map['weather'] as List).map<WeatherModel>(
          (x) => WeatherModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      TemperatureModel.fromMap(map['main'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherResponseModel.fromJson(String source) =>
      WeatherResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WeatherResponseModel(coord: $coord, weather: $weather, main: $main)';
}
