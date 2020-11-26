import 'package:flutter/material.dart';
import 'package:test_app/landing_page.dart';
import 'package:test_app/home.dart';
import 'package:test_app/calculatedAnswer.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/': (context) => WelcomeScreen(),
    '/home': (context) => Home(),
    '/calculatedAnswer': (context) => CalculatedPage()
  },
));