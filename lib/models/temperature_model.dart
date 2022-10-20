import 'dart:convert';

class TemperatureModel {
  final num? temp;
  final num? feelsLike;
  final num? tempMin;
  final num? tempMax;
  final num? pressure;
  final num? humidity;
  final num? seaLevel;
  final num? grndLevel;

  TemperatureModel(this.temp, this.feelsLike, this.tempMin, this.tempMax,
      this.pressure, this.humidity, this.seaLevel, this.grndLevel);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'temp': temp,
      'feels_like': feelsLike,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'pressure': pressure,
      'humidity': humidity,
      'sea_level': seaLevel,
      'grnd_level': grndLevel,
    };
  }

  factory TemperatureModel.fromMap(Map<String, dynamic> map) {
    return TemperatureModel(
      map['temp'] != null ? map['temp'] as num : null,
      map['feels_like'] != null ? map['feels_like'] as num : null,
      map['temp_min'] != null ? map['temp_min'] as num : null,
      map['temp_max'] != null ? map['temp_max'] as num : null,
      map['pressure'] != null ? map['pressure'] as num : null,
      map['humidity'] != null ? map['humidity'] as num : null,
      map['sea_level'] != null ? map['sea_level'] as num : null,
      map['grnd_level'] != null ? map['grnd_level'] as num : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TemperatureModel.fromJson(String source) =>
      TemperatureModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TemperatureModel(temp: $temp, feelsLike: $feelsLike, tempMin: $tempMin, tempMax: $tempMax, pressure: $pressure, humidity: $humidity, seaLevel: $seaLevel, grndLevel: $grndLevel)';
  }
}
