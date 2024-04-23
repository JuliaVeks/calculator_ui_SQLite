class CalculatorLogic {
  double _operand1 = 0;
  double _operand2 = 0;
  String _operator = '';

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
    return result.toString();
  }

  void clear() {
    _operand1 = 0;
    _operand2 = 0;
    _operator = '';
  }
}
