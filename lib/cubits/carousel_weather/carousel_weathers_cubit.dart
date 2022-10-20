import 'package:bloc/bloc.dart';
import 'package:weather_app/models/cities_model.dart';
import 'package:weather_app/services/cities_services.dart';

part 'carousel_weathers_state.dart';

class CarouselWeathersCubit extends Cubit<CarouselWeathersState> {
  CarouselWeathersCubit() : super(CarouselWeathersInitial());

  List<CitiesModel> cityToDisplay = [];
  final cities = CitiesServices().getCities()!;

  init(List<int> indices) {
    for (var i = 0; i < indices.length; i++) {
      final city = cities.firstWhere((element) => element.id == indices[i]);
      cityToDisplay.add(city);
    }
    emit(CarouselWeathersLoaded(cityToDisplay));
  }

  addCity(int index) {
    if (cityToDisplay.length >= 3) {
      return;
    }
    final city = cities.firstWhere((element) => element.id == index);
    cityToDisplay.add(city);

    emit(CarouselWeathersLoaded(cityToDisplay));
  }

  removeCity(int index) {
    if (cityToDisplay.length == 1 || index == 0) {
      return 0;
    }
    cityToDisplay.removeWhere((element) => element.id == index);
    emit(CarouselWeathersLoaded(cityToDisplay));
  }
}
