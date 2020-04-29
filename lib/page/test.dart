import 'package:base/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 300,
              height: 80,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  border: MyBorder(),
                ),
                child: Center(
                  child: Text('hello'),
                ),
              ),
            )
          ],
        ),
      ),
//      backgroundColor: Colors.red,
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
      ..shader = gradient.createShader(Rect.fromPoints(Offset(0, 10),Offset(100, 100)))
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

class _MyGradient extends Gradient {
  @override
  Shader createShader(Rect rect, {TextDirection textDirection}) {
    LinearGradient(colors: null);
    return null;
  }

  @override
  Gradient scale(double factor) {
    // TODO: implement scale
    return null;
  }
}
