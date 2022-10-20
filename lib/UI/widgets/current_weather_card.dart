import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/DI/injector_container.dart';
import 'package:weather_app/UI/screens/location_weather_screen.dart';
import 'package:weather_app/cubits/fetch_current_weather/fetch_current_weather_cubit.dart';
import 'package:weather_app/models/cities_model.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/extensions.dart';
import 'package:weather_app/utils/spaces.dart';

class CurrentWeatherCard extends StatefulWidget {
  final CitiesModel city;
  final int currentIndex;
  final int length;

  const CurrentWeatherCard(
      {super.key,
      required this.city,
      required this.currentIndex,
      required this.length});

  @override
  State<CurrentWeatherCard> createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard> {
  final FetchCurrentWeatherCubit _fetchCurrentWeatherCubit = injector.get();
  LocationPermission? permission;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchCurrentWeatherCubit>(
      create: (context) => _fetchCurrentWeatherCubit,
      child: BlocBuilder<FetchCurrentWeatherCubit, FetchCurrentWeatherState>(
        bloc: _fetchCurrentWeatherCubit
          ..getCurrentWeather(lat: widget.city.lat!, lon: widget.city.lng!),
        builder: (context, state) {
          if (state is FetchCurrentWeatherLoading) {
            return const Center(
                child: CircularProgressIndicator(
              color: white,
            ));
          }
          if (state is FetchCurrentWeatherLoaded) {
            final main = state.weatherResponse.main;
            return Column(
              children: [
                VerticalSpace(size: context.height(.05)),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
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
                      icon: Icon(
                        Icons.location_on_outlined,
                        color: red,
                        size: context.width(.07),
                      )),
                ),
                VerticalSpace(size: context.height(.1)),
                Text(
                  widget.city.city ?? "",
                  style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w400,
                      fontSize: context.width(.08)),
                ),
                VerticalSpace(size: context.height(.01)),
                Text(
                  "${main.temp?.round()}°",
                  style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w700,
                      fontSize: context.width(.2)),
                ),
                Text(
                  state.weatherResponse.weather.first.main ?? "",
                  style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w400,
                      fontSize: context.width(.08)),
                ),
                VerticalSpace(size: context.height(.02)),
                Text(
                  "High: ${main.tempMax?.round()}°   Low: ${main.tempMin?.round()}°",
                  style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w400,
                      fontSize: context.width(.04)),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: widget.currentIndex == index ? 35 : 17,
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: white.withOpacity(.5)),
                          color: widget.currentIndex == index
                              ? white
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalSpace(
                  size: context.height(.04),
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
