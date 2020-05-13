import 'package:flutter/material.dart';

///使用InheritedWidget 存数据
class BaseColor extends InheritedWidget {
  final Color _color;

  Color get color => _color;

  BaseColor(
    this._color, {
    Key key,
    Widget child,
  }) : super(key: key, child: child);

  //获取保存的数据
  static BaseColor of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BaseColor>();
  }

  @override
  bool updateShouldNotify(BaseColor oldWidget) {
    return oldWidget.color != _color;
  }
}
