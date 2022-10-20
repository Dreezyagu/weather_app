import 'package:get_it/get_it.dart';
import 'package:weather_app/cubits/carousel_weather/carousel_weathers_cubit.dart';
import 'package:weather_app/cubits/fetch_cities/fetch_cities_cubit.dart';
import 'package:weather_app/cubits/fetch_current_weather/fetch_current_weather_cubit.dart';

void cubitsInit(GetIt injector) {
  injector
      .registerLazySingleton(() => FetchCurrentWeatherCubit(injector.get()));
  injector.registerLazySingleton(() => FetchCitiesCubit(injector.get()));
  injector.registerLazySingleton(() => CarouselWeathersCubit());
}
