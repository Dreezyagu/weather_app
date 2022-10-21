import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/DI/injector_container.dart';
import 'package:weather_app/UI/screens/location_weather_screen.dart';
import 'package:weather_app/UI/widgets/cities_card.dart';
import 'package:weather_app/UI/widgets/current_weather_card.dart';
import 'package:weather_app/cubits/carousel_weather/carousel_weathers_cubit.dart';
import 'package:weather_app/cubits/fetch_cities/fetch_cities_cubit.dart';
import 'package:weather_app/models/cities_model.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FetchCitiesCubit _fetchCitiesCubit = injector.get();
  final CarouselWeathersCubit _carouselWeathersCubit = injector.get();

  List<CitiesModel> displayCities = [];
  @override
  void initState() {
    _fetchCitiesCubit.fetchCities();
    _carouselWeathersCubit.init();
    super.initState();
  }

  LocationPermission? permission;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _fetchCitiesCubit),
        BlocProvider.value(value: _carouselWeathersCubit)
      ],
      child: Scaffold(
        backgroundColor: background,
        body: BlocBuilder<CarouselWeathersCubit, CarouselWeathersState>(
          builder: (context, state) {
            if (state is CarouselWeathersLoaded) {
              displayCities = state.citiesModel;
              return Stack(
                children: [
                  FractionallySizedBox(
                    heightFactor: .55,
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: homeGradient,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(context.width(.15)),
                            bottomRight: Radius.circular(context.width(.15)),
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: PageView.builder(
                              itemCount: displayCities.length,
                              itemBuilder: (context, index) {
                                return CurrentWeatherCard(
                                  length: displayCities.length,
                                  currentIndex: index,
                                  city: displayCities[index],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: .45,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.width(.04)),
                        child: BlocBuilder<FetchCitiesCubit, FetchCitiesState>(
                          builder: (context, viewState) {
                            if (viewState is FetchCitiesLoaded) {
                              return ValueListenableBuilder(
                                valueListenable: _fetchCitiesCubit.cities,
                                builder: (context, cities, child) {
                                  return SizedBox(
                                    child: ListView.builder(
                                      itemCount: cities.length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        final city = cities[index];
                                        final onDisplay = displayCities
                                            .map((e) => e.city)
                                            .contains(city.city);
                                        return CitiesCard(
                                            onDisplay: onDisplay, city: city);
                                      },
                                    ),
                                  );
                                },
                              );
                            }
                            if (state is FetchCitiesError) {
                              return ErrorWidget.withDetails(
                                  message:
                                      "An error occurred. Check your internet");
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is CarouselWeathersError) {
              return ErrorWidget.withDetails(
                  message: "An error occurred. Check your internet");
            }
            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            permission = await Geolocator.requestPermission();
            if (permission != LocationPermission.denied) {
              await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high)
                  .then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationWeatherScreen(
                        lat: value.latitude.toString(),
                        lon: value.longitude.toString(),
                      ),
                    ));
                return;
              });
            }
          },
          child: Icon(
            Icons.location_on_outlined,
            color: white,
            size: context.width(.07),
          ),
        ),
      ),
    );
  }
}
