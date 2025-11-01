import 'package:flutter/material.dart';

extension SpacerExt on double {
  Widget get v => SizedBox(height: this);
  Widget get h => SizedBox(width: this);
}

extension SpacerIntExt on int {
  Widget get v => SizedBox(height: toDouble());
  Widget get h => SizedBox(width: toDouble());
}
