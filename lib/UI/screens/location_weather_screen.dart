import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/DI/injector_container.dart';
import 'package:weather_app/cubits/fetch_current_weather/fetch_current_weather_cubit.dart';

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
      body: Center(
        child: BlocBuilder<FetchCurrentWeatherCubit, FetchCurrentWeatherState>(
          bloc: _fetchCurrentWeatherCubit
            ..getCurrentWeather(lat: widget.lat, lon: widget.lon),
          builder: (context, state) {
            if (state is FetchCurrentWeatherLoading) {
              return const CircularProgressIndicator();
            }
            if (state is FetchCurrentWeatherLoaded) {
              return Column(
                children: [
                  const Text("Your current location"),
                  Text(state.weatherResponse.main.temp.toString()),
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
