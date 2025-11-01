import 'package:core/core.dart';
import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  const MainText(this.text, {super.key, this.style});
  final String? text;
  final TextStyle? style;
  MainText copyWith({String? text, TextStyle? style}) => MainText(
        text ?? this.text,
        style: style ?? this.style,
      );
  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: style ?? context.style(),
    );
  }
}
