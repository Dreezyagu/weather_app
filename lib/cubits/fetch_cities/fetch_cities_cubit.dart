import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/models/cities_model.dart';
import 'package:weather_app/services/cities_services.dart';

part 'fetch_cities_state.dart';

class FetchCitiesCubit extends Cubit<FetchCitiesState> {
  final CitiesServices services;
  FetchCitiesCubit(this.services) : super(FetchCitiesInitial());

  final ValueNotifier<List<CitiesModel>> _cities = ValueNotifier([]);

  ValueNotifier<List<CitiesModel>> get cities => _cities;

  void fetchCities() {
    emit(FetchCitiesLoading());
    final response = services.getCities();
    if (response != null) {
      _cities.value = response;
      emit(FetchCitiesLoaded(_cities.value));
    } else {
      emit(FetchCitiesError());
    }
  }

  void arrange(List<CitiesModel> displayCities) {
    for (var element in displayCities) {
      _cities.value.removeWhere((e) => e.city == element.city);
    }
    _cities.value.insertAll(0, displayCities);

    // emit(FetchCitiesLoading());
    // emit(FetchCitiesLoaded(cities));
  }
}
