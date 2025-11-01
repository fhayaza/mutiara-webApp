import 'package:flutter/material.dart';

extension WdigetBuilder on Widget {
  Widget builder(Widget Function(Widget parent) build) => build(this);
}
