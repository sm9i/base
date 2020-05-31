import 'package:base/widget/route/route_manager.dart';
import 'package:flutter/material.dart';

class DRouteObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route previousRoute) {
    RouteManager.remove(route, previousRoute: previousRoute);
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route previousRoute) {
    RouteManager.add(route);
    super.didPush(route, previousRoute);
  }
}
