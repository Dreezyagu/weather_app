part of 'fetch_cities_cubit.dart';

abstract class FetchCitiesState {}

class FetchCitiesInitial extends FetchCitiesState {}

class FetchCitiesLoaded extends FetchCitiesState {
  final List<CitiesModel> citiesModel;

  FetchCitiesLoaded(this.citiesModel);
}

class FetchCitiesError extends FetchCitiesState {}

class FetchCitiesLoading extends FetchCitiesState {}
