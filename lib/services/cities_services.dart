import 'package:weather_app/models/cities_model.dart';

class CitiesServices {
  static const List<Map<String, dynamic>> citiesJson = [
    {
      "id": 0,
      "city": "Lagos",
      "lat": "6.4500",
      "lng": "3.4000",
    },
    {
      "id": 1,
      "city": "Abuja",
      "lat": "9.0556",
      "lng": "7.4914",
    },
    {
      "id": 2,
      "city": "Ibadan",
      "lat": "7.3964",
      "lng": "3.9167",
    },
    {
      "id": 3,
      "city": "Enugu",
      "lat": "6.4403",
      "lng": "7.4942",
    },
    {
      "id": 4,
      "city": "Maiduguri",
      "lat": "11.8333",
      "lng": "13.1500",
    },
    {
      "id": 5,
      "city": "Nsukka",
      "lat": "6.8567",
      "lng": "7.3958",
    },
    {
      "id": 6,
      "city": "Port Harcourt",
      "lat": "4.7500",
      "lng": "7.0000",
    },
    {
      "id": 7,
      "city": "Abeokuta",
      "lat": "7.1500",
      "lng": "3.3500",
    },
    {
      "id": 8,
      "city": "Jos",
      "lat": "9.9333",
      "lng": "8.8833",
    },
    {
      "id": 9,
      "city": "Kaduna",
      "lat": "10.5231",
      "lng": "7.4403",
    },
    {
      "id": 10,
      "city": "Onitsha",
      "lat": "6.1667",
      "lng": "6.7833",
    },
    {
      "id": 11,
      "city": "Owerri",
      "lat": "5.4833",
      "lng": "7.0333",
    },
    {
      "id": 12,
      "city": "Sokoto",
      "lat": "13.0622",
      "lng": "5.2339",
    },
    {
      "id": 13,
      "city": "Calabar",
      "lat": "4.9500",
      "lng": "8.3250",
    },
    {
      "id": 14,
      "city": "Katsina",
      "lat": "12.9889",
      "lng": "7.6008",
    },
  ];

  List<CitiesModel>? getCities() {
    try {
      final cities = citiesJson.map((e) => CitiesModel.fromMap(e)).toList();
      return cities;
    } catch (e) {
      return null;
    }
  }
}
