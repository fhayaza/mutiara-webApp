import 'package:flutter/material.dart';

extension TexttyleExt on BuildContext {
  TextStyle? style() => Theme.of(this).textTheme.bodyMedium;
}
