import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatefulWidget {
  @override
  _ThemePageState createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  Color defColor = Color(0xFFE5322D);

  ThemeData get darkTheme => ThemeData.dark().copyWith(
        //设置status 颜色 [Brightness.light] 是黑色图标+文字
        brightness: Brightness.light,
        primaryColor: Colors.grey[900],
        accentColor: defColor,
      );

  ThemeData get lightTheme => ThemeData.light().copyWith(
        primaryColor: Colors.white,
        accentColor: defColor,
        brightness: Brightness.light,
        textSelectionColor: defColor.withAlpha(100),
        textSelectionHandleColor: Colors.white,
      );

  ScrollController _scrollController = new ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      appBar: AppBar(
        title: Text('theme demo'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            child: Theme(
              data: lightTheme,
              child: Builder(builder: (context) {
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: ListView(
                    controller: _scrollController,
                    children: <Widget>[
                      AppBar(),
                      Text(
                        'title',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text(
                        'd1',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Text(
                        'd2',
                        style: Theme.of(context).textTheme.display2,
                      ),
                      Text(
                        'd3',
                        style: Theme.of(context).textTheme.display3,
                      ),
                      Text(
                        'd4',
                        style: Theme.of(context).textTheme.display4,
                      ),
                      Text(
                        'body1',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Text(
                        'body2',
                        style: Theme.of(context).textTheme.body2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Center(child: Text('card')),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {},
                      ),
                      SelectableText('select text'),
                    ],
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: Theme(
              data: darkTheme,
              child: Builder(builder: (context) {
                return Container(
                  color: Theme.of(context).primaryColor,
                  child: ListView(
                    controller: _scrollController,
                    children: <Widget>[
                      AppBar(),
                      Text(
                        'title',
                        style: Theme.of(context).textTheme.title,
                      ),
                      Text(
                        'd1',
                        style: Theme.of(context).textTheme.display1,
                      ),
                      Text(
                        'd2',
                        style: Theme.of(context).textTheme.display2,
                      ),
                      Text(
                        'd3',
                        style: Theme.of(context).textTheme.display3,
                      ),
                      Text(
                        'd4',
                        style: Theme.of(context).textTheme.display4,
                      ),
                      Text(
                        'body1',
                        style: Theme.of(context).textTheme.body1,
                      ),
                      Text(
                        'body2',
                        style: Theme.of(context).textTheme.body2,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Center(child: Text('card')),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
