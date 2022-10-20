import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/DI/injector_container.dart';
import 'package:weather_app/UI/screens/location_weather_screen.dart';
import 'package:weather_app/UI/widgets/current_weather_card.dart';
import 'package:weather_app/cubits/carousel_weather/carousel_weathers_cubit.dart';
import 'package:weather_app/cubits/fetch_cities/fetch_cities_cubit.dart';
import 'package:weather_app/utils/extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FetchCitiesCubit _fetchCitiesCubit = injector.get();
  final CarouselWeathersCubit _carouselWeathersCubit = injector.get();
  LocationPermission? permission;
  @override
  void initState() {
    _fetchCitiesCubit.fetchCities();
    _carouselWeathersCubit.init([0, 1, 2]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _fetchCitiesCubit),
        BlocProvider.value(value: _carouselWeathersCubit),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
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
                icon: const Icon(Icons.location_on_outlined))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              BlocBuilder<CarouselWeathersCubit, CarouselWeathersState>(
                builder: (context, state) {
                  if (state is CarouselWeathersLoaded) {
                    final displayCities = state.citiesModel;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: context.height(.5),
                          child: PageView.builder(
                            itemCount: displayCities.length,
                            itemBuilder: (context, index) {
                              return CurrentWeatherCard(
                                city: displayCities[index],
                              );
                            },
                          ),
                        ),
                        BlocBuilder<FetchCitiesCubit, FetchCitiesState>(
                          builder: (context, viewState) {
                            if (viewState is FetchCitiesLoaded) {
                              final cities = viewState.citiesModel;
                              return SizedBox(
                                height: context.height(.1),
                                child: ListView.builder(
                                  itemCount: cities.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    final city = cities[index];
                                    final onDisplay = displayCities
                                        .map((e) => e.id)
                                        .contains(city.id);
                                    return InkWell(
                                      onTap: () {
                                        if (onDisplay) {
                                          injector
                                              .get<CarouselWeathersCubit>()
                                              .removeCity(index);
                                        } else {
                                          injector
                                              .get<CarouselWeathersCubit>()
                                              .addCity(index);
                                        }
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                width: 2,
                                                color: onDisplay
                                                    ? Colors.red
                                                    : Colors.white)),
                                        child: Center(
                                            child: Text(city.city ?? "")),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
