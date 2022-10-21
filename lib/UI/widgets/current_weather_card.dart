import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/DI/injector_container.dart';
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
                VerticalSpace(size: context.height(.08)),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.width(.04),
                      vertical: context.height(.01)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: locationGradient),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/icons/pin.svg"),
                      Text(
                        "  ${widget.city.city ?? ""}",
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.w400,
                            fontSize: context.width(.04)),
                      ),
                    ],
                  ),
                ),
                VerticalSpace(size: context.height(.03)),
                SvgPicture.asset(
                  state.weatherResponse.weather.first.main?.toLowerCase() ==
                          "rain"
                      ? "assets/icons/rain.svg"
                      : "assets/icons/sun.svg",
                  height: context.height(.1),
                ),
                VerticalSpace(size: context.height(.03)),
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
                      fontSize: context.width(.05)),
                ),
                VerticalSpace(size: context.height(.02)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "     High: ${main.tempMax?.round()}°°",
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w300,
                          fontSize: context.width(.04)),
                    ),
                    Text(
                      "Low: ${main.tempMin?.round()}°     ",
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w300,
                          fontSize: context.width(.04)),
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    widget.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: widget.currentIndex == index ? 30 : 17,
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: white.withOpacity(.5)),
                          color: widget.currentIndex == index
                              ? blueDark
                              : blueLight,
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalSpace(
                  size: context.height(.02),
                )
              ],
            );
          }
          if (state is FetchCurrentWeatherError) {
            return ErrorWidget.withDetails(
                message: "An error occurred. Check your internet");
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
