import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_app/DI/injector_container.dart';
import 'package:weather_app/cubits/fetch_cities/fetch_cities_cubit.dart';
import 'package:weather_app/models/cities_model.dart';
import 'package:weather_app/services/cities_services.dart';
import 'package:weather_app/utils/storage_helper.dart';
import 'package:weather_app/utils/storage_keys.dart';

part 'carousel_weathers_state.dart';

class CarouselWeathersCubit extends Cubit<CarouselWeathersState> {
  CarouselWeathersCubit() : super(CarouselWeathersInitial());

  List<CitiesModel> cityToDisplay = [];
  final cities = CitiesServices().getCities()!;

  void init() async {
    var persistedCities = (await getPersistedCities()) ?? ["Lagos"];
    for (var i = 0; i < persistedCities.length; i++) {
      final city = cities.firstWhere(
          (element) => element.city.toString() == persistedCities[i]);
      cityToDisplay.add(city);
    }
    persistCities(cityToDisplay);
    injector.get<FetchCitiesCubit>().arrange(cityToDisplay);
    emit(CarouselWeathersLoaded(cityToDisplay));
  }

  Future<List<String>?> getPersistedCities() async {
    return await StorageHelper.getStringList(StorageKeys.persistCities);
  }

  void persistCities(List<CitiesModel> cities) {
    final List<String> cityIdToString = cityToDisplay
        .map(
          (e) => e.city!,
        )
        .toList();
    StorageHelper.setStringList(StorageKeys.persistCities, cityIdToString);
  }

  void addCity(String name) {
    if (cityToDisplay.length >= 3) {
      Fluttertoast.showToast(
          msg: "Carousel full. Remove a displayed city to add a new one",
          toastLength: Toast.LENGTH_LONG);
      return;
    }
    final city = cities.firstWhere((element) => element.city == name);
    cityToDisplay.insert(0, city);
    persistCities(cityToDisplay);
    injector.get<FetchCitiesCubit>().arrange(cityToDisplay);
    emit(CarouselWeathersLoaded(cityToDisplay));
  }

  void removeCity(String name) {
    if (cityToDisplay.length == 1) {
      return;
    }
    cityToDisplay.removeWhere((element) => element.city == name);
    persistCities(cityToDisplay);
    injector.get<FetchCitiesCubit>().arrange(cityToDisplay);
    emit(CarouselWeathersLoaded(cityToDisplay));
  }
}
