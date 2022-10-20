import 'package:bloc/bloc.dart';
import 'package:weather_app/models/weather_response_model.dart';
import 'package:weather_app/services/weather_services.dart';

part 'fetch_current_weather_state.dart';

class FetchCurrentWeatherCubit extends Cubit<FetchCurrentWeatherState> {
  final WeatherServices services;
  FetchCurrentWeatherCubit(this.services) : super(FetchCurrentWeatherInitial());

  Future<void> getCurrentWeather(
      {required String lon, required String lat}) async {
    emit(FetchCurrentWeatherLoading());
    final response = await services.fetchCurrentWeather(lon: lon, lat: lat);
    if (response.item1 is WeatherResponseModel) {
      emit(FetchCurrentWeatherLoaded(response.item1!));
    } else {
      emit(FetchCurrentWeatherError(response.item2 ?? "An error occurred"));
    }
  }
}
