import 'package:flutter/material.dart';

class PositionPage extends StatefulWidget {
  @override
  _PositionPageState createState() => _PositionPageState();
}

class _PositionPageState extends State<PositionPage> {
  FixedExtentScrollController _scrollController =new FixedExtentScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('2'),
      ),
      body: ListView(
        controller: _scrollController,
        children: <Widget>[
          Container(height: 300, color: Colors.red),
          GestureDetector(
            child: Container(height: 300, color: Colors.black),
            onTap: () {
              _scrollController.animateToItem(4,
                  duration: Duration(microseconds: 100),
                  curve: Curves.bounceInOut);
            },
          ),
          Container(height: 300, color: Colors.accents[0]),
          Container(height: 300, color: Colors.white),
          Container(height: 300, color: Colors.blue),
          Container(height: 300, color: Colors.green),
          Container(height: 300, color: Colors.deepOrange),
        ],
      ),
    );
  }
}
