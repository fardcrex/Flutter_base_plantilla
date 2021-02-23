import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final String titlePage;
  const HomePage({Key key, this.titlePage}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titlePage),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text(titlePage),
      ),
    );
  }
}
