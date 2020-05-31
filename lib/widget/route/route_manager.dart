import 'dart:collection';

import 'package:base/widget/route/route_observer.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static final DRouteObserver _routeObserver = new DRouteObserver();

  RouteManager._();

  static HashMap<Route, Route> _routes = HashMap();
  static Route _firstRoute;

  static void add(Route route) {
    _routes[route] = route;
    _firstRoute = route;
  }

  static void remove(Route route, {Route previousRoute}) {
    if (_routes.containsKey(route)) _routes.remove(route);
    _firstRoute = previousRoute;
  }


  static Route get firstRoute => _firstRoute;

  static Iterable<Route> get allRoute => _routes.values;

  static DRouteObserver get routeObserver => _routeObserver;
}
