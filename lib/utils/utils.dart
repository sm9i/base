import 'package:flutter/foundation.dart';

/// 只在调试模式打印
void trueDebugPrint(String message, {int wrapWidth}) {
  if (!kReleaseMode) {
    debugPrint(message, wrapWidth: wrapWidth);
  }
}
