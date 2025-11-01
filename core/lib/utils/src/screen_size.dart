import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  double height(double percentage, {double? min, double? max}) {
    final res = MediaQuery.of(this).size.height * percentage;
    if (min != null && res <= min) return min;
    if (max != null && res >= max) return max;
    return res;
  }

  double rsize(double percentage, {double? min, double? max}) {
    double res = 0;
    if (MediaQuery.of(this).size.width > MediaQuery.of(this).size.height) {
      res = MediaQuery.of(this).size.height * percentage;
    } else {
      res = MediaQuery.of(this).size.width * percentage;
    }
    if (min != null && res <= min) return min;
    if (max != null && res >= max) return max;
    return res;
  }

  double width(double percentage, {double? min, double? max}) {
    final res = MediaQuery.of(this).size.width * percentage;
    if (min != null && res <= min) return min;
    if (max != null && res >= max) return max;
    return res;
  }

  double fontSize(double size, {double? min, double? max}) {
    double res = rsize(1) / size;
    if (min != null && res <= min) return min;
    if (max != null && res >= max) return max;
    return res;
  }
}

extension SizeLimiter on double {
  double limit({double? min, double? max}) {
    if (min != null && this <= min) return min;
    if (max != null && this >= max) return max;
    return this;
  }
}
