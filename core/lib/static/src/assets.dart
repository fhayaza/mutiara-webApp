class Assets {
  static const String assets = "assets";
  static final images = _Images();
  static final icons = _Icons();
}

class _Icons {
  // ignore: unused_field
  static const String icons = "${Assets.assets}/icons";
}

class _Images {
  static const String images = "${Assets.assets}/images";
  final String digitelnusa = "$images/digitelnusa.png";
}
