import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/DI/injector_container.dart';
import 'package:weather_app/cubits/fetch_current_weather/fetch_current_weather_cubit.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/extensions.dart';
import 'package:weather_app/utils/spaces.dart';

class LocationWeatherScreen extends StatefulWidget {
  final String lat;
  final String lon;

  const LocationWeatherScreen(
      {super.key, required this.lat, required this.lon});

  @override
  State<LocationWeatherScreen> createState() => _LocationWeatherScreenState();
}

class _LocationWeatherScreenState extends State<LocationWeatherScreen> {
  final FetchCurrentWeatherCubit _fetchCurrentWeatherCubit = injector.get();

  @override
  void initState() {
    _fetchCurrentWeatherCubit.getCurrentWeather(
        lon: widget.lon, lat: widget.lat);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: homeGradient),
        child: BlocBuilder<FetchCurrentWeatherCubit, FetchCurrentWeatherState>(
          bloc: _fetchCurrentWeatherCubit
            ..getCurrentWeather(lat: widget.lat, lon: widget.lon),
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
                  VerticalSpace(size: context.height(.1)),
                  Text(
                    "Your current location:",
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
