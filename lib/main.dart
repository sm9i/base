import 'package:base/page/position_page.dart';
import 'package:base/page/test.dart';
import 'package:base/page/theme_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = new AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AnimatedIcon(icon: AnimatedIcons.list_view, progress: _animationController);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          ListTile(
            title: Text('test pahge'),
            onTap: () {
              _goPage(TestPage());
            },
          ),
          ListTile(
            title: Text('theme pahge'),
            onTap: () {
              _goPage(ThemePage());
            },
          ),
          ListTile(
            title: Text('position pahge'),
            onTap: () {
              _goPage(PositionPage());
            },
          ),
          ListTile(
            title: Text('key listener'),
            onTap: () {
              print("2");

              RawKeyboard.instance.addListener((s) {
                print(s.data.hashCode);
              });
            },
          ),
          RawKeyboardListener(
            onKey: (key) {
              print((key.data as RawKeyEventDataAndroid).keyCode);
            },
            focusNode: FocusNode(),
            child: TextField(),
          )
        ],
      ),
    );
  }

  _goPage(Widget child) {
    return Navigator.push(
        context, new MaterialPageRoute(builder: (_) => child));
  }
}
