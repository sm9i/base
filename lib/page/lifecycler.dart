import 'package:flutter/widgets.dart';

/**
 * 生命周期的回调
 * Page级别:onPageCreate page创建  onPageDispose() page销毁
 */

/// Register the RouteObserver as a navigation observer.
/// MaterialApp 中添加此路由监听
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

abstract class IPageLifecycle {
  final bool _printLog = false;

  //页面级别的
  void onPageDispose() {
    if (_printLog) print("$this destory");
  }

  //页面级别的
  void onPageCreate(BuildContext context) {
    if (_printLog) print("$this create");
  }

  void onPageResume() {
    if (_printLog) print("$this resume");
  }

  void onPagePause() {
    if (_printLog) print("$this pause");
  }
}

mixin PageLifecycleMixin<T extends StatefulWidget> on State<T>
    implements RouteAware, IPageLifecycle
{
  _AppLifecycleWidgetsBindingObserver _lifecycleObserver;
  bool _printLog = false;

  //是否在栈顶
  bool _isTop = false;

  bool routeAware;

  @override
  void initState() {
    super.initState();
    _lifecycleObserver =
        _AppLifecycleWidgetsBindingObserver(_lifecycleStateCallback);
    WidgetsBinding.instance.addObserver(_lifecycleObserver);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageCreate(context);
      onPageResume();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (routeAware) {
      routeObserver.subscribe(this, ModalRoute.of(context));
    }
  }

  @override
  void dispose() {
    if (routeAware) {
      routeObserver.unsubscribe(this);
    }
    WidgetsBinding.instance.removeObserver(_lifecycleObserver);
    _lifecycleObserver = null;
    onPageDispose();
    super.dispose();
  }

  _lifecycleStateCallback(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      if (_isTop) {
        onPagePause();
      }
    }
    if (state == AppLifecycleState.resumed) {
      if (_isTop) {
        onPageResume();
      }
    }
  }

  @override
  void didPop() {
    //弹出
    onPagePause();
    _isTop = false;
  }

  @override
  void didPopNext() {
    //上一个弹出
    onPageResume();
    _isTop = true;
  }

  @override
  void didPush() {
    //入栈
    _isTop = true;
  }

  @override
  void didPushNext() {
    //跳转到下一个
    onPagePause();
    _isTop = false;
  }

  //页面级别的
  void onPageDispose() {
    if (_printLog) print("$this destory");
  }

  //页面级别的
  void onPageCreate(BuildContext context) {
    if (_printLog) print("$this create");
  }

  void onPageResume() {
    if (_printLog) print("$this resume");
  }

  void onPagePause() {
    if (_printLog) print("$this pause");
  }
}

/// app生命周期
mixin AppLifecycleMixin<T extends StatefulWidget> on State<T> {
  _AppLifecycleWidgetsBindingObserver _lifecycleObserver;

  @override
  void initState() {
    super.initState();
    _lifecycleObserver =
        _AppLifecycleWidgetsBindingObserver(_lifecycleStateCallback);
    WidgetsBinding.instance.addObserver(_lifecycleObserver);
  }

  _lifecycleStateCallback(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      onBackground();
    }

    if (state == AppLifecycleState.resumed) {
      onForeground();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(_lifecycleObserver);
    _lifecycleObserver = null;
    super.dispose();
  }

  //应用级别的
  void onBackground() {
    print("App onBackground");
  }

  //应用级别的
  void onForeground() {
    print("App onForeground");
  }
}

class _AppLifecycleWidgetsBindingObserver extends WidgetsBindingObserver {
  final Function(AppLifecycleState) lifecycleStateCallback;

  _AppLifecycleWidgetsBindingObserver(this.lifecycleStateCallback);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    lifecycleStateCallback(state);
  }
}

class PageLifecycleWidget extends StatefulWidget {
  final Widget child;
  final Function(BuildContext context) onCreate;
  final Function() onResume;
  final Function() onPause;
  final Function() onDispose;
  final bool routeAware; //是否监听路由

  PageLifecycleWidget(
      {Key key,
      this.child,
      this.routeAware = false,
      this.onCreate,
      this.onResume,
      this.onPause,
      this.onDispose})
      : super(key: key);

  @override
  _PageLifecycleWidgetState createState() => _PageLifecycleWidgetState();
}

class _PageLifecycleWidgetState extends State<PageLifecycleWidget>
    with PageLifecycleMixin {
  @override
  void onPageCreate(BuildContext context) {
    if (widget.onCreate != null) {
      widget.onCreate(context);
    }
  }

  @override
  void didUpdateWidget(PageLifecycleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.routeAware != widget.routeAware) {
      routeAware = widget.routeAware;
    }
  }

  @override
  void onPageDispose() {
    if (widget.onDispose != null) {
      widget.onDispose();
    }
  }

  @override
  void onPagePause() {
    if (widget.onPause != null) {
      widget.onPause();
    }
  }

  @override
  void onPageResume() {
    if (widget.onResume != null) {
      widget.onResume();
    }
  }

  @override
  void initState() {
    routeAware = widget.routeAware;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
