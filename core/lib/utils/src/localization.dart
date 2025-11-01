import 'package:core/core.dart';
import 'package:flutter/widgets.dart';

extension Locali on BuildContext {
  L? l() => L.of(this);
}
