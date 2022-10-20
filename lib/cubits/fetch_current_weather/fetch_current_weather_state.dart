part of 'fetch_current_weather_cubit.dart';

abstract class FetchCurrentWeatherState {}

class FetchCurrentWeatherInitial extends FetchCurrentWeatherState {}

class FetchCurrentWeatherLoading extends FetchCurrentWeatherState {}

class FetchCurrentWeatherLoaded extends FetchCurrentWeatherState {
  final WeatherResponseModel weatherResponse;
  FetchCurrentWeatherLoaded(this.weatherResponse);
}

class FetchCurrentWeatherError extends FetchCurrentWeatherState {
  final String error;
  FetchCurrentWeatherError(this.error);
}
