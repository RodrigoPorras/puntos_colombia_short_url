import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:puntos_colombia_short_url/src/presentation/views/home/home_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, path: '/'),
      ];
}

final appRouter = AppRouter();
