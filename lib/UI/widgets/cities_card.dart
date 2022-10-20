import 'package:flutter/material.dart';
import 'package:weather_app/DI/injector_container.dart';
import 'package:weather_app/models/cities_model.dart';
import 'package:weather_app/utils/colors.dart';
import 'package:weather_app/utils/extensions.dart';

import '../../cubits/carousel_weather/carousel_weathers_cubit.dart';

class CitiesCard extends StatelessWidget {
  const CitiesCard({
    Key? key,
    required this.onDisplay,
    required this.city,
  }) : super(key: key);

  final bool onDisplay;
  final CitiesModel city;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: false,
      onTap: () {
        if (onDisplay) {
          injector.get<CarouselWeathersCubit>().removeCity(city.city!);
        } else {
          injector.get<CarouselWeathersCubit>().addCity(city.city!);
        }
      },
      child: Card(
        color: onDisplay ? red : Colors.transparent,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
                width: 1,
                color: onDisplay ? Colors.transparent : white.withOpacity(.5))),
        child: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width(.01)),
                child: Text(
                  city.city ?? "",
                  style: TextStyle(
                      color: white,
                      fontWeight: FontWeight.w400,
                      fontSize: context.width(.04)),
                ))),
      ),
    );
  }
}
