import 'package:IMC/home.dart';
import 'package:flutter/material.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IMC',
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}