import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorLogic {
  double _operand1 = 0;
  double _operand2 = 0;
  String _operator = '';
  String _display = '0';

  void setOperand(double operand) {
    if (_operator.isEmpty) {
      _operand1 = operand;
    } else {
      _operand2 = operand;
    }
  }

  void setOperator(String operator) {
    _operator = operator;
  }

  String calculate() {
    double result = 0;
    switch (_operator) {
      case '+':
        result = _operand1 + _operand2;
        break;
      case '-':
        result = _operand1 - _operand2;
        break;
      case '*':
        result = _operand1 * _operand2;
        break;
      case '/':
        result = _operand1 / _operand2;
        break;
    }
    return result.toString();
  }

  void clear() {
    _operand1 = 0;
    _operand2 = 0;
    _operator = '';
  }

  String get display => _display;
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _calculatorLogic = CalculatorLogic();
  String _display = '0';

  void _onButtonPressed(String text) {
    setState(() {
      if (text == '=') {
        _display = _calculatorLogic.calculate();
      } else if (text == 'C') {
        _calculatorLogic.clear();
        _display = '0';
      } else {
        if (text == '+' || text == '-' || text == '*' || text == '/') {
          _calculatorLogic.setOperator(text);
        } else {
          _calculatorLogic.setOperand(double.parse(text));
        }
        _display = _calculatorLogic.display; // Заменяем _calculatorLogic._display на _calculatorLogic.display
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор'),
      ),
      body: CalculatorBody(onButtonPressed: _onButtonPressed, display: _display),
    );
  }
}

class CalculatorBody extends StatelessWidget {
  final Function(String) onButtonPressed;
  final String display;

  const CalculatorBody({Key? key, required this.onButtonPressed, required this.display}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            display,
            style: const TextStyle(fontSize: 24.0),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CalculatorButton('7', onButtonPressed),
              CalculatorButton('8', onButtonPressed),
              CalculatorButton('9', onButtonPressed),
              CalculatorButton('/', onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CalculatorButton('4', onButtonPressed),
              CalculatorButton('5', onButtonPressed),
              CalculatorButton('6', onButtonPressed),
              CalculatorButton('*', onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CalculatorButton('1', onButtonPressed),
              CalculatorButton('2', onButtonPressed),
              CalculatorButton('3', onButtonPressed),
              CalculatorButton('-', onButtonPressed),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CalculatorButton('0', onButtonPressed),
              CalculatorButton('.', onButtonPressed),
              CalculatorButton('=', onButtonPressed),
              CalculatorButton('+', onButtonPressed),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function(String) onPressed;

  const CalculatorButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(text),
      child: Text(text),
    );
  }
}

