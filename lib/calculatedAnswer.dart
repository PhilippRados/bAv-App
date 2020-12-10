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
    return SafeArea(
      child: Scaffold(
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
                    margin: EdgeInsets.only(top: 10, bottom: 15, left: 25),
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
                    margin: EdgeInsets.fromLTRB(20, 12, 20, 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0XFFC7D93E),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            HeroDialogRoute(
                                builder: (BuildContext context) =>
                                    GrosserText()));
                      },
                      child: Hero(
                        tag: "basicResult",
                        child: Text(
                          "Sie zahlen selbst nur ${this.nettoAufwand}€ Vom Staat erhalten Sie ${this.steuerErsparnis}€ Zuschusszusätzlich (hier nicht in der Grafik angegeben) dazu",
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
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
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
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
                              style:
                                  TextStyle(fontSize: 17, color: Colors.white),
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
      )),
    );
  }
}

class GrosserText extends StatefulWidget {
  @override
  _GrosserTextState createState() => _GrosserTextState();
}

class _GrosserTextState extends State<GrosserText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 50),
      child: Center(
        child: AlertDialog(
          title: Hero(
              tag: "hero2",
              child: Material(
                  child: Text(
                'Detailliertere Auswertung:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ))),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Hero(
                tag: 'hero1',
                child: Text(
                  "Siete 2",
                )),
          ),
          actions: <Widget>[
            OutlineButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      ),
    );
  }
}

class HeroDialogRoute<T> extends PageRoute<T> {
  HeroDialogRoute({this.builder}) : super();

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get maintainState => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return new FadeTransition(
        opacity: new CurvedAnimation(parent: animation, curve: Curves.easeOut),
        child: child);
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context);
  }

  @override
  String get barrierLabel => null;
}
