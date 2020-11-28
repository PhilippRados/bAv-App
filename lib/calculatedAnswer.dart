import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' as Io;
import 'dart:convert';
import 'package:test_app/detailedAnswer.dart';

class CalculatedPage extends StatelessWidget {
  final image;

  CalculatedPage({Uint8List this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          alignment: Alignment.bottomLeft,
          child: IconButton(
              icon: Icon(CupertinoIcons.arrowtriangle_left_fill),
              onPressed: () => Navigator.pop(context, '/home')),
        ),
        Center(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30, bottom: 15, left: 25),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Ihre Auswertung",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ),
                Container(
                    //margin: EdgeInsets.only(top: 120),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.memory(this.image),
                    )),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Text(
                    "Sie zahlen selbst nur 321.37§ Vom Staat erhalten Sie 198% Zuschusszusätzlich (hier nicht in der Grafik angegeben)dazu",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(550),
                    color: Color(0XFF256075),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        minWidth: 100,
                        height: 50,
                        color: Colors.amber,
                        onPressed: () => {},
                        child: Text(
                          "Neuberechnen",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      FlatButton(
                        minWidth: 150,
                        height: 50,
                        color: Colors.redAccent,
                        onPressed: () => {},
                        child: Text(
                          "Weiter",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
