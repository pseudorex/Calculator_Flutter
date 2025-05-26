import 'package:flutter/material.dart';
import 'package:interest_calculator/screens/modern_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ModernCalculator(),
    );
  }
}
