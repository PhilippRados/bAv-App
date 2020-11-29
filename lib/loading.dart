import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';

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
              // SpinKitWave(
              //   color: Colors.black,
              //   size: 50,
              // ),
              Lottie.asset(
                'assets/38217-money-growth.json',
                repeat: true,
                reverse: false,
                animate: true,
              ),
              SizedBox(height: 30),
              Text(
                "Eingaben werden ausgerechnet...",
                style: TextStyle(fontSize: 18, color: Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
