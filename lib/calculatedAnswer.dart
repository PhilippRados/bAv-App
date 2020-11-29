import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' as Io;
import 'dart:convert';

class CalculatedPage extends StatelessWidget {
  final image;
  final nettoAufwand;
  final steuerErsparnis;

  CalculatedPage(
      {Uint8List this.image,
      String this.nettoAufwand,
      String this.steuerErsparnis});

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
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 30),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color(0XFFC7D93E),
                  ),
                  child: Text(
                    "Sie zahlen selbst nur ${this.nettoAufwand}€ Vom Staat erhalten Sie ${this.steuerErsparnis}€ Zuschusszusätzlich (hier nicht in der Grafik angegeben) dazu",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 170,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0XFF36C6DD)),
                        child: FlatButton(
                          onPressed: () => {},
                          child: Text(
                            "Neuberechnen",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0XFF518293)),
                        child: FlatButton(
                          onPressed: () => {},
                          child: Text(
                            "Weiter",
                            style: TextStyle(fontSize: 17, color: Colors.white),
                          ),
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
