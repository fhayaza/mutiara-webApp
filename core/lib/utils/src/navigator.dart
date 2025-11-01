import 'package:core/core.dart';
import 'package:flutter/material.dart';

extension NavigatorRoute on BuildContext {
  Uri getCurrentRoute() => GoRouter.of(this).routeInformationProvider.value.uri;
  String withCurrentRoute(String input) => getCurrentRoute().path + input;
  Future<T?> materialPush<T>(Widget page) => Navigator.push<T>(
      this,
      MaterialPageRoute(
        builder: (context) => page,
      ));
  Future<T?> pushDialog<T extends Object?>(Widget page, {Color? barrierColor}) {
    return Navigator.push<T>(
        this,
        PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            barrierColor: barrierColor ?? const Color.fromARGB(125, 158, 158, 158),
            pageBuilder: (BuildContext context, _, __) => page));
  }
}
