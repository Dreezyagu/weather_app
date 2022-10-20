import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tuple/tuple.dart';
import 'package:weather_app/models/weather_response_model.dart';

const baseUrl = "https://api.openweathermap.org";

class WeatherServices {
  final dio = Dio();
  Future<Tuple2<WeatherResponseModel?, String?>> fetchCurrentWeather(
      {required String lon, required String lat}) async {
    try {
      final response = await dio.get(
          "$baseUrl/data/2.5/weather?lat=$lat&lon=$lon&appid=bc274eb3fc8c7a2c6b244b16718a1625&units=metric");

      if (response.statusCode == 200) {
        final WeatherResponseModel weatherResponseModel =
            WeatherResponseModel.fromMap(response.data);

        return Tuple2(weatherResponseModel, null);
      } else {
        return const Tuple2(null, "An error occurred");
      }
    } catch (e) {
      log(e.toString());
      return const Tuple2(null, "An error occurred");
    }
  }
}
