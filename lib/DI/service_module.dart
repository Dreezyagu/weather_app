import 'package:get_it/get_it.dart';
import 'package:weather_app/services/cities_services.dart';
import 'package:weather_app/services/weather_services.dart';

void servicesInit(GetIt injector) {
  injector.registerLazySingleton(() => WeatherServices());
  injector.registerLazySingleton(() => CitiesServices());

}
