import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Init Config'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
