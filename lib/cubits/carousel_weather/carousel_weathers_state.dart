part of 'carousel_weathers_cubit.dart';

abstract class CarouselWeathersState {}

class CarouselWeathersInitial extends CarouselWeathersState {}

class CarouselWeathersLoaded extends CarouselWeathersState {
  final List<CitiesModel> citiesModel;

  CarouselWeathersLoaded(this.citiesModel);
}

class CarouselWeathersLoading extends CarouselWeathersState {}

class CarouselWeathersError extends CarouselWeathersState {}
