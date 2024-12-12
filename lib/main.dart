import 'package:flutter/material.dart';
import 'screens/random_numbers_screen.dart';

void main() {
  runApp(const RandomNumbersApp());
}

class RandomNumbersApp extends StatelessWidget {
  const RandomNumbersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ordene os números',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomNumbersScreen(),
    );
  }
}
