import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitWave(
                color: Colors.black,
                size: 50,
              ),
              SizedBox(height: 30),
              Text(
                "Eingaben werden ausgerechnet...",
                style: TextStyle(fontSize: 14, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
