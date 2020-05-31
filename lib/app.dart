import 'package:flutter/material.dart';


class App {
  static GlobalKey<NavigatorState> _globalKey = new GlobalKey();

  static GlobalKey<NavigatorState> get globalKey => _globalKey;
}
