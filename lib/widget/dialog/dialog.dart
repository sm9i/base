import 'package:base/app.dart';
import 'package:base/widget/route/route.dart';
import 'package:base/widget/route/route_manager.dart';
import 'package:flutter/material.dart';


class DialogUtil {
  static bool _isShowing = false;

  static Future<T> showDialog<T>() {
    if (hasDialogRoute()) return null;
    return App.globalKey.currentState.push<T>(
      DialogRoute(
        pageBuilder: (BuildContext context, _, __) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        barrierDismissible: false,
      ),
    );
  }

  static bool hasDialogRoute() {
    //判断 rout是否存在  如果存在就不跳  否则就跳
    bool has1 = (RouteManager.firstRoute?.settings?.name ?? '') == 'dialog';
    bool has2 = RouteManager.allRoute
            .where((w) => (w.settings?.name ?? '') == 'dialog')
            .length >=
        1;
    if (has1 || has2 || _isShowing) {
      return true;
    }

    return false;
  }

  static Future clearDialog() {
    _isShowing = false;
    RouteManager.allRoute
        .firstWhere((w) => (w.settings?.name ?? '') == 'dialog')
        .navigator
        .pop();
    return null;
  }
}
