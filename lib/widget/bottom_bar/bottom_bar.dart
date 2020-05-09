import 'package:flutter/material.dart';

import 'bottom_bar_model.dart';

class BottomBar extends StatelessWidget {
  //挡圈选中的index
  final int currentIndex;

  //底部items
  final List<BottomBarItem> bottomBarItems;

  const BottomBar({
    Key key,
    @required this.bottomBarItems,
    this.currentIndex = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(bottomBarItems == null || bottomBarItems.length <= 1,
        "[bottomBarItems] cannot be empty");
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [for (int i = 0; i < bottomBarItems.length; i++) item(i)],
    );
  }

  Widget item(int i) {
    final bool select = i == currentIndex;
    return Builder(builder: (context) {
      return Column(
        children: <Widget>[
          Image.asset(
            select
                ? bottomBarItems[i].selectedIcon
                : bottomBarItems[i].unSelectedIcon,
            fit: BoxFit.fill,
          ),
          SizedBox(height: 8),
          Text(
            '${bottomBarItems[i].title}',
            style: TextStyle(
              color: select
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).textTheme.display4.color,
            ),
          ),
        ],
      );
    });
  }
}
