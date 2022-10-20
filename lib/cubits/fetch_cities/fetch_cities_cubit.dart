import 'package:bloc/bloc.dart';
import 'package:weather_app/models/cities_model.dart';
import 'package:weather_app/services/cities_services.dart';

part 'fetch_cities_state.dart';

class FetchCitiesCubit extends Cubit<FetchCitiesState> {
  final CitiesServices services;
  FetchCitiesCubit(this.services) : super(FetchCitiesInitial());

  void fetchCities() {
    emit(FetchCitiesLoading());
    final response = services.getCities();
    if (response != null) {
      emit(FetchCitiesLoaded(response));
    } else {
      emit(FetchCitiesError());
    }
  }
}
