import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'calculator_history.dart';// Для форматирования даты и времени
import 'database_helper.dart';// Импортируем помощника базы данных

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
        if (_operand2 != 0) {
          result = _operand1 / _operand2;
        } else {
          return 'Error: Division by zero';
        }
        break;
    }
    _saveCalculationHistory(_operand1, _operand2, _operator, result);
    return result.toString();
  }

  void _saveCalculationHistory(double operand1, double operand2, String operator, double result) async {
    try {
      String expression = '$operand1 $operator $operand2';
      await HistoryDatabase.instance.insertHistory(CalculationHistory(
        id: null,
        expression: expression,
        result: result.toString(),
        timestamp: DateTime.now(),
      ));
    } catch (e) {
      print('Failed to save calculation history: $e');
    }
  }

  void clear() {
    _operand1 = 0;
    _operand2 = 0;
    _operator = '';
  }

  String get display => _display;
}
