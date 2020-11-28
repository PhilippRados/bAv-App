import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:io' as Io;
import 'dart:convert';

class CalculatedPage extends StatelessWidget {
  final image;

  CalculatedPage({Uint8List this.image});

  //final decoded_graph = base64Decode(image);

  //final Base64Codec decoded_image = base64Decode(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Ihre Auswertung"), backgroundColor: Colors.grey[900]),
        body: Container(
          child: Column(
            children: <Widget>[
              Image.memory(this.image),
            ],
          ),
        ));
  }
}
