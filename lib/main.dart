import 'package:flutter/material.dart';
import 'calculator_screen.dart';
import 'calculator_logic.dart';
import 'km_to_miles_converter_widget.dart';
import 'distance_converter_logic.dart';



void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const CalculatorScreen(), // Отображаем экран калькулятора
    );
  }
}
