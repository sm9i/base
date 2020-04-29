import 'package:base/page/position_page.dart';
import 'package:base/page/test.dart';
import 'package:base/page/theme_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }

  _goPage(Widget child) {
    return Navigator.push(
        context, new MaterialPageRoute(builder: (_) => child));
  }
}
