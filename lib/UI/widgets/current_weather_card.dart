
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/DI/injector_container.dart';
import 'package:weather_app/cubits/fetch_current_weather/fetch_current_weather_cubit.dart';
import 'package:weather_app/models/cities_model.dart';

class CurrentWeatherCard extends StatefulWidget {
  final CitiesModel city;

  const CurrentWeatherCard({super.key, required this.city});

  @override
  State<CurrentWeatherCard> createState() => _CurrentWeatherCardState();
}

class _CurrentWeatherCardState extends State<CurrentWeatherCard> {
  final FetchCurrentWeatherCubit _fetchCurrentWeatherCubit = injector.get();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchCurrentWeatherCubit>(
      create: (context) => _fetchCurrentWeatherCubit,
      child: Column(
        children: [
          BlocBuilder<FetchCurrentWeatherCubit, FetchCurrentWeatherState>(
            bloc: _fetchCurrentWeatherCubit
              ..getCurrentWeather(lat: widget.city.lat!, lon: widget.city.lng!),
            builder: (context, state) {
              if (state is FetchCurrentWeatherLoading) {
                return const CircularProgressIndicator();
              }
              if (state is FetchCurrentWeatherLoaded) {
                return Column(
                  children: [
                    Text(widget.city.city ?? ""),
                    Text(state.weatherResponse.main.temp.toString()),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          )
        ],
      ),
    );
  }
}
