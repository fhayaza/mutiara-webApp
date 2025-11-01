import '../features/catalogue/catalogue_page.dart';
import 'package:core/core.dart';
import '../features/main/main_page.dart';
import 'package:flutter/material.dart';

final GoRouter router = GoRouter(
  initialLocation: PathRoutes.catalogue.pather(),
  routes: <RouteBase>[
    GoRoute(
      path: PathRoutes.root,
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
    ),
    GoRoute(
      path: PathRoutes.catalogue.pather(),
      builder: (BuildContext context, GoRouterState state) {
        return const CataloguePage();
      },
    ),
  ],
);
