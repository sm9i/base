import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List<String> images = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final physics = TextPhysic();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.change_history),
              onPressed: () {
                print("22");
                physics.setScroll(!physics.allowImplicitScrolling);
              }),
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        physics: physics,
        itemBuilder: (_, __) => TestWidget(),
        itemCount: 30,
      ),
    );
  }
}

class TextPhysic extends ScrollPhysics {
  TextPhysic({ScrollPhysics parent}) : super(parent: parent);

  @override
  TextPhysic applyTo(ScrollPhysics ancestor) {
    return TextPhysic(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return isScroll;
  }

  bool isScroll = true;

  void setScroll(bool isScroll) {
    isScroll = isScroll;
  }
}

//测试listView中 item高度变了之后其他item是否bulid

//并不会
class TestWidget extends StatefulWidget {
  final int index;

  const TestWidget({Key key, this.index}) : super(key: key);

  @override
  _TestWidgetState createState() => _TestWidgetState();
}

class _TestWidgetState extends State<TestWidget> {
  double _height = 200;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _height = 300;
        });
      },
      child: Container(
        height: _height,
        color: Color.fromARGB(
          255,
          math.Random.secure().nextInt(255),
          math.Random.secure().nextInt(255),
          math.Random.secure().nextInt(255),
        ),
      ),
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
