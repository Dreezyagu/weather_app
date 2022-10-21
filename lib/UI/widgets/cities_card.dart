import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
    return Card(
        margin: EdgeInsets.symmetric(vertical: context.height(.01)),
        color: blackLight,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 1, color: Color(0xff011631))),
        child: ListTile(
          onTap: () {
            if (onDisplay) {
              injector.get<CarouselWeathersCubit>().removeCity(city.city!);
            } else {
              injector.get<CarouselWeathersCubit>().addCity(city.city!);
            }
          },
          contentPadding: EdgeInsets.symmetric(
              vertical: context.height(.01), horizontal: context.width(.04)),
          title: Text(
            city.city ?? "",
            style: TextStyle(
                color: grey,
                fontWeight: FontWeight.w400,
                fontSize: context.width(.045)),
          ),
          trailing: onDisplay ? SvgPicture.asset("assets/icons/pin.svg") : null,
        ));
  }
}
