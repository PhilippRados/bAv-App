import 'package:flutter/material.dart';

class CalculatedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Ihre Auswertung"), backgroundColor: Colors.grey[900]),
        body: Container(
          child: Column(
            children: <Widget>[Image.asset("assets/graph.png")],
          ),
        ));
  }
}