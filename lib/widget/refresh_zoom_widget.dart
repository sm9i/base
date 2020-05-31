import 'dart:ui';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

typedef HeaderBuilder = Widget Function(BuildContext context);
typedef ItemBuilder<T> = Widget Function<T>(BuildContext context, T t);

///下拉头部变焦
///[T] item
class RefreshZoomWidget<T> extends StatefulWidget {
  final HeaderBuilder header;
  final ItemBuilder<T> item;
  final List<T> data;

  const RefreshZoomWidget({
    Key key,
    @required this.header,
    @required this.item,
    @required this.data,
  })  : assert(item != null && header != null && data != null),
        super(key: key);

  @override
  _RefreshZoomWidgetState<T> createState() => _RefreshZoomWidgetState<T>();
}

class _RefreshZoomWidgetState<T> extends State<RefreshZoomWidget> {
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
    return PullToRefreshNotification(
      onRefresh: () async {
        return await Future.delayed(Duration(milliseconds: 3000), () => true);
      },
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _RefreshHeaderWidget(
              header: widget.header,
            );
          } else {
            return widget.item<T>(context, widget.data[index - 1]);
          }
        },
        itemCount: widget.data.length + 1,
      ),
    );
  }
}

class _RefreshHeaderWidget extends StatelessWidget {
  final HeaderBuilder header;

  const _RefreshHeaderWidget({Key key, this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultHeight = MediaQuery.of(context).size.height * 0.4;

    return PullToRefreshContainer(
      (PullToRefreshScrollNotificationInfo info) {
        final offset = math.min((info?.dragOffset ?? 0.0), 100.0);
        print(info?.mode);
        return Container(
          height: defaultHeight + offset,
          width: double.infinity,
          color: Colors.red,
          child: Transform.scale(
            scale: 1 + offset / 1000,
            child: Image.network(
              'http://p3.music.126.net/WvycJs_TU3RnbPGv6AUHFg==/109951164754514726.jpg',
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }


}

//class _RefreshHeaderWidget extends StatefulWidget {
//  final HeaderBuilder header;
//
//  const _RefreshHeaderWidget({
//    Key key,
//    this.header,
//  }) : super(key: key);
//
//  @override
//  __RefreshHeaderWidgetState createState() => __RefreshHeaderWidgetState();
//}
//
//class __RefreshHeaderWidgetState extends State<_RefreshHeaderWidget> {
//  double defaultHeight =
//      window.physicalSize.height / window.devicePixelRatio * 0.4;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: defaultHeight,
//      color: Colors.red,
//      child: widget.he,
//    );
//  }
//}

class AlwaysPhysics extends ClampingScrollPhysics {
  const AlwaysPhysics({ScrollPhysics parent}) : super(parent: parent);

  @override
  AlwaysPhysics applyTo(ScrollPhysics ancestor) {
    return AlwaysPhysics(parent: buildParent(ancestor));
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return true;
  }
}
