import 'package:flutter/material.dart';

const Color white = Colors.white;
const Color grey = Color(0xff66707C);
const Color background = Color(0xff000D1D);
const Color red = Color(0xffEE6C4D);
const Color blueLight = Color(0xff6595E8);
const Color blueDark = Color(0xff052761);
const Color blackLight = Color(0xff001125);

const Gradient homeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff1366F0),
      Color(0xff1465F2),
    ]);

Gradient locationGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      const Color(0xffFBFCFD).withOpacity(.5),
      const Color(0xff8BB0C5).withOpacity(.63)
    ]);
