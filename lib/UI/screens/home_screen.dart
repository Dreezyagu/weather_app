import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/DI/injector_container.dart';
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

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _fetchCitiesCubit),
        BlocProvider.value(value: _carouselWeathersCubit),
      ],
      child: Scaffold(
        backgroundColor: background,
        body: BlocBuilder<CarouselWeathersCubit, CarouselWeathersState>(
          builder: (context, state) {
            if (state is CarouselWeathersLoaded) {
              displayCities = state.citiesModel;
              return Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: context.width(.02)),
                    child: FractionallySizedBox(
                      heightFactor: .8,
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
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FractionallySizedBox(
                      heightFactor: .2,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.width(.02),
                            vertical: context.height(.05)),
                        child: BlocBuilder<FetchCitiesCubit, FetchCitiesState>(
                          builder: (context, viewState) {
                            if (viewState is FetchCitiesLoaded) {
                              return ValueListenableBuilder(
                                valueListenable: _fetchCitiesCubit.cities,
                                builder: (context, cities, child) {
                                  return SizedBox(
                                    child: ListView.builder(
                                      itemCount: cities.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final city = cities[index];
                                        final onDisplay = displayCities
                                            .map((e) => e.city)
                                            .contains(city.city);
                                        return InkWell(
                                          enableFeedback: false,
                                          onTap: () {
                                            if (onDisplay) {
                                              injector
                                                  .get<CarouselWeathersCubit>()
                                                  .removeCity(city.city!);
                                            } else {
                                              injector
                                                  .get<CarouselWeathersCubit>()
                                                  .addCity(city.city!);
                                            }
                                          },
                                          child: Card(
                                            color: onDisplay
                                                ? red
                                                : Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                side: BorderSide(
                                                    width: 1,
                                                    color: onDisplay
                                                        ? Colors.transparent
                                                        : white
                                                            .withOpacity(.5))),
                                            child: Center(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: context
                                                                .width(.01)),
                                                    child: Text(
                                                      city.city ?? "",
                                                      style: TextStyle(
                                                          color: white,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: context
                                                              .width(.04)),
                                                    ))),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
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
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
