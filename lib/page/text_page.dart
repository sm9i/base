import 'package:flutter/material.dart';

class TextPage extends StatefulWidget {
  @override
  _TextPageState createState() => _TextPageState();
}

class _TextPageState extends State<TextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('text'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 200,
              height: 200,
              child: CustomPaint(
                painter: _Text(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Text extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width,
          height: size.height),
      Paint()..color = Colors.blue,
    );
    final painter = TextPainter(
      text: TextSpan(text: "你好", style: TextStyle(color: Colors.red)),
      textDirection: TextDirection.ltr,
    );

    painter.layout(maxWidth: size.width);
    painter.paint(canvas, Offset(0,0));
    print(painter.width);
    print(painter.height);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
