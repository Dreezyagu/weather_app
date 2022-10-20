import 'package:flutter/material.dart';

extension CustomContext on BuildContext {
  Orientation orientation() => MediaQuery.of(this).orientation;
  double height([double percent = 1]) {
    return orientation() == Orientation.portrait
        ? MediaQuery.of(this).size.height * percent
        : MediaQuery.of(this).size.width * percent;
  }

  double width([double percent = 1]) {
    {
      return orientation() == Orientation.landscape
          ? MediaQuery.of(this).size.height * percent
          : MediaQuery.of(this).size.width * percent;
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    } else {
      return "${this[0].toUpperCase()}${substring(1)}";
    }
  }
}
