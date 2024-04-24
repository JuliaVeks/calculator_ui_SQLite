import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Для форматирования даты и времени
import 'calculator_history.dart'; // Импортируем модель истории
import 'database_helper.dart'; // Импортируем помощника базы данных


class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<CalculationHistory> _historyList = []; // Список для хранения истории

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Загружаем историю при инициализации экрана
  }

  Future<void> _loadHistory() async {
    List<CalculationHistory> history = await HistoryDatabase.instance.getHistory();
    setState(() {
      _historyList = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('История'),
      ),
      body: _buildHistoryList(),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      itemCount: _historyList.length,
      itemBuilder: (context, index) {
        CalculationHistory historyItem = _historyList[index];
        return ListTile(
          title: Text('${historyItem.expression} = ${historyItem.result}'),
          subtitle: Text(DateFormat.yMMMd().add_jm().format(historyItem.timestamp)), // Форматируем дату и время
        );
      },
    );
  }
}
