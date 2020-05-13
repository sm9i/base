import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CanvasPage extends StatefulWidget {
  @override
  _CanvasPageState createState() => _CanvasPageState();
}

class _CanvasPageState extends State<CanvasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AspectRatio(
            aspectRatio: 1,
            child: LayoutBuilder(builder: (_, constraints) {
              return _ChessWidget(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _ChessWidget extends StatefulWidget {
  final double width;
  final double height;

  const _ChessWidget({Key key, this.width, this.height}) : super(key: key);

  @override
  __ChessWidgetState createState() => __ChessWidgetState();
}

class __ChessWidgetState extends State<_ChessWidget> {
  List<EventPosition> chess = [];
  double _defaultValue;
  bool success = false;

  @override
  void initState() {
//    chess.add(EventPosition(4, 2));
    _defaultValue = widget.width / 10;
    super.initState();
  }

  onPointerUp(PointerUpEvent event) {
    final dx = event.localPosition.dx;
    final dy = event.localPosition.dy;
    var positionX;
    var positionY;

    ///如果点击的位置大于阕值的一半
    ///当前位置就是 余数
    if (dx % _defaultValue < _defaultValue / 2) {
      positionX = dx ~/ _defaultValue;
    } else {
      positionX = (dx ~/ _defaultValue) + 1;
    }
    if (dy % _defaultValue < _defaultValue / 2) {
      positionY = dy ~/ _defaultValue;
    } else {
      positionY = (dy ~/ _defaultValue) + 1;
    }
    final eventPosition = EventPosition(positionX, positionY);

    //如果已经存在点
    if (chess.contains(eventPosition)) {
      return;
    }

    //如果长度为0 就直接添加
    if (chess.length == 0) {
      chess.add(eventPosition);
    } else {
      chess.add(eventPosition
        ..chessUser = chess.last.chessUser == ChessUser.black
            ? ChessUser.white
            : ChessUser.black);
    }
    setState(() {});
    checkSuccess();
  }

  void checkSuccess() {
    final last = chess.last;
    List<EventPosition> user = List.from(
        chess.where((element) => element.chessUser == last.chessUser));

    if (_mathRow(user) ||
        _mathColumn(user) ||
        _rightDown(user) ||
        _leftDown(user)) {
      this.success = true;
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('${last.chessUser.toString()} is succeeded')));
    }
  }

  bool _rightDown(List<EventPosition> data) {
    HashMap<int, List<EventPosition>> map = new HashMap();

    ///转为map
    data.forEach((element) {
      int key = (element.pX - element.pY);
      if (map.containsKey(key)) {
        map[key].add(element);
      } else {
        map[key] = [];
        map[key].add(element);
      }
    });

    ///删除掉不够5个长度的row
    map.removeWhere((key, value) => value.length < 5);
    //记录连接数 每次循环会重置
    int cSuccess = 1;
    if (map.length != 0) {
      map.forEach((key, value) {
        if (cSuccess == 5) {
          return;
        }
        cSuccess = 1;
        value.sort((a, b) => a.pY.compareTo(b.pY));
        List.generate(4, (index) {
          if (value[index].pY + 1 == value[index + 1].pY) {
            cSuccess++;
          }
        });
      });
      if (cSuccess == 5) {
        return true;
      }
    }
    return false;
  }

  bool _leftDown(List<EventPosition> data) {
    HashMap<int, List<EventPosition>> map = new HashMap();

    ///转为map
    data.forEach((element) {
      int key = (element.pX + element.pY);
      if (map.containsKey(key)) {
        map[key].add(element);
      } else {
        map[key] = [];
        map[key].add(element);
      }
    });

    ///删除掉不够5个长度的row
    map.removeWhere((key, value) => value.length < 5);
    //记录连接数 每次循环会重置
    int cSuccess = 1;
    if (map.length != 0) {
      map.forEach((key, value) {
        if (cSuccess == 5) {
          return;
        }
        cSuccess = 1;
        value.sort((a, b) => a.pX.compareTo(b.pX));
        List.generate(4, (index) {
          if (value[index].pX + 1 == value[index + 1].pX) {
            cSuccess++;
          }
        });
      });
      if (cSuccess == 5) {
        return true;
      }
    }
    return false;
  }

  bool _mathColumn(List<EventPosition> data) {
    HashMap<int, List<EventPosition>> map = new HashMap();

    ///转为map
    data.forEach((element) {
      if (map.containsKey(element.pX)) {
        map[element.pX].add(element);
      } else {
        map[element.pX] = [];
        map[element.pX].add(element);
      }
    });

    ///删除掉不够5个长度的row
    map.removeWhere((key, value) => value.length < 5);
    //记录连接数 每次循环会重置
    int cSuccess = 1;
    if (map.length != 0) {
      map.forEach((key, value) {
        if (cSuccess == 5) {
          return;
        }
        cSuccess = 1;
        value.sort((a, b) => a.pY.compareTo(b.pY));
        List.generate(4, (index) {
          if (value[index].pY + 1 == value[index + 1].pY) {
            cSuccess++;
          }
        });
      });
      if (cSuccess == 5) {
        return true;
      }
    }
    return false;
  }

  bool _mathRow(List<EventPosition> data) {
    HashMap<int, List<EventPosition>> map = new HashMap();

    ///转为map
    data.forEach((element) {
      if (map.containsKey(element.pY)) {
        map[element.pY].add(element);
      } else {
        map[element.pY] = [];
        map[element.pY].add(element);
      }
    });

    ///删除掉不够5个长度的row
    map.removeWhere((key, value) => value.length < 5);
    int cSuccess = 1;
    if (map.length != 0) {
      map.forEach((key, value) {
        if (cSuccess == 5) {
          return;
        }
        cSuccess = 1;
        value.sort((a, b) => a.pX.compareTo(b.pX));
        List.generate(4, (index) {
          if (value[index].pX + 1 == value[index + 1].pX) {
            cSuccess++;
          }
        });
      });
      if (cSuccess == 5) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: onPointerUp,
      onPointerDown: (_) {
        if (success) {
          chess.clear();
          success = false;
          setState(() {});
        }
      },
      child: CustomPaint(
        painter: _ChessPainter(
          _defaultValue,
          chess,
        ),
      ),
    );
  }
}

class _ChessPainter extends CustomPainter {
  // 间隔值
  final double defValue;
  final List<EventPosition> chess;

  _ChessPainter(this.defValue, this.chess);

  @override
  void paint(Canvas canvas, Size size) {
    drawBack(canvas, size);
    drawX(canvas, size);
    drawY(canvas, size);
    drawPoint(canvas, size);
  }

  void drawPoint(Canvas canvas, Size size) {
    for (final point in chess) {
      canvas.drawCircle(
          Offset(point.pX * defValue, point.pY * defValue),
          defValue / 3,
          Paint()
            ..color = point.chessUser == ChessUser.black
                ? Colors.black
                : Colors.white);
    }
  }

  void drawX(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 0.7;

    List.generate(11, (i) {
      canvas.drawLine(
          Offset(i * defValue, 0), Offset(i * defValue, size.height), paint);
    });
  }

  void drawY(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..strokeWidth = 0.7;
    List.generate(11, (i) {
      canvas.drawLine(
          Offset(0, i * defValue), Offset(size.width, i * defValue), paint);
    });
  }

  void drawBack(Canvas canvas, Size size) {
    canvas.drawRect(
        Rect.fromCenter(
          center: Offset(size.width / 2, size.height / 2),
          width: size.width,
          height: size.height,
        ),
        Paint()..color = Colors.grey.withOpacity(0.5));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

enum ChessUser { black, white }

class EventPosition {
  final int pX;
  final int pY;
  ChessUser chessUser;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventPosition &&
          runtimeType == other.runtimeType &&
          pX == other.pX &&
          pY == other.pY;

  @override
  int get hashCode => pX.hashCode ^ pY.hashCode;

  EventPosition(this.pX, this.pY, {this.chessUser = ChessUser.black});

  @override
  String toString() {
    return '$pX,$pY';
  }
}
