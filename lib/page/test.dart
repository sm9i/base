import 'dart:typed_data';

import 'package:base/widget/app_bar.dart';
import 'package:base/widget/dots_indicator.dart';
import 'package:base/widget/image_list.dart';
import 'package:base/widget/inth_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/physics.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<String> images = [];

  @override
  void initState() {
    List.generate(
        10,
        (index) => images.add(
            "https://ss3.bdstatic.com/lPoZeXSm1A5BphGlnYG/skin/48$index.jpg"));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leading: Icon(Icons.chevron_left),
        action: Icon(Icons.more_horiz),
        title: Text('2'),
        boxDecoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blueAccent, Colors.blue])),
      ),
      backgroundColor: Colors.white,

    );
  }
}

class A extends BoxScrollView {
  @override
  Widget buildChildLayout(BuildContext context) {
    return Column(
      children: <Widget>[Text('2')],
    );
  }
}

class MyBorder extends BoxBorder {
  @override
  BorderSide get bottom => BorderSide();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  bool get isUniform => true;

  @override
  void paint(Canvas canvas, Rect rect,
      {TextDirection textDirection,
      BoxShape shape = BoxShape.rectangle,
      BorderRadius borderRadius}) {
    final Gradient gradient = new LinearGradient(
      colors: [
        Colors.black12,
        Colors.white,
        Colors.red,
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    Paint paint = new Paint()
      ..color = Colors.red
      ..strokeWidth = 100
      ..shader = gradient
          .createShader(Rect.fromPoints(Offset(0, 10), Offset(100, 100)))
      ..style = PaintingStyle.fill;
    canvas.drawLine(rect.topLeft, rect.topRight, paint);
//    canvas.drawRect(Rect.fromPoints(Offset(0, 10),Offset(100, 100)), paint);
  }

  @override
  ShapeBorder scale(double t) {
    return Border(
      top: top.scale(t),
      right: bottom.scale(t),
      bottom: bottom.scale(t),
      left: top.scale(t),
    );
  }

  @override
  BorderSide get top => BorderSide();
}

class IconAnimatedWidget extends StatefulWidget {
  @override
  _IconAnimatedWidgetState createState() => _IconAnimatedWidgetState();
}

class _IconAnimatedWidgetState extends State<IconAnimatedWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 300));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            AnimatedIcon(
              icon: AnimatedIcons.ellipsis_search,
              progress: _animationController,
            ),
            RaisedButton(
              onPressed: () {
                if (_animationController.isAnimating) return;
                _animationController.reverse();
              },
              child: Icon(Icons.stop),
            ),
            RaisedButton(
              onPressed: () {
                if (_animationController.isAnimating) return;
                _animationController.forward();
              },
              child: Icon(Icons.play_arrow),
            )
          ],
        ),
      ),
    );
  }
}
