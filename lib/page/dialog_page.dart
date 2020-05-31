import 'package:base/widget/dialog/dialog.dart';
import 'package:base/widget/route/route_manager.dart';
import 'package:flutter/material.dart';

class DialogPage extends StatefulWidget {
  @override
  _DialogPageState createState() => _DialogPageState();
}

class _DialogPageState extends State<DialogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                DialogUtil.showDialog();
                Future.delayed(Duration(milliseconds: 3000), () {
                  DialogUtil.clearDialog();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
