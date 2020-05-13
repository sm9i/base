import 'package:flutter/material.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BoxDecoration boxDecoration;
  final Widget leading;
  final Widget action;
  final bool centerTitle;
  final Widget title;
  final double elevation;

  const BaseAppBar({
    Key key,
    this.boxDecoration,
    this.leading,
    this.action,
    this.centerTitle = false,
    this.title,
    this.elevation = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultBoxDecoration = BoxDecoration(
      color: AppBarTheme.of(context).color ?? Colors.white,
    );
    return Material(
      elevation: elevation,
      child: Container(
        decoration: boxDecoration ?? defaultBoxDecoration,
        height: preferredSize.height,
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
          ),
          child: Row(
            children: <Widget>[
              if (leading != null)
                SizedBox(
                  width: 50,
                  child: GestureDetector(
                    child: leading,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              Expanded(
                child: Container(
                  alignment:
                      centerTitle ? Alignment.center : Alignment.centerLeft,
                  child: title,
                ),
              ),
              if (action != null)
                SizedBox(
                  width: 50,
                  child: action,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(75);
}
