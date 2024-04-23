// km_to_miles_converter_widget.dart


import 'package:flutter/material.dart';
import 'distance_converter_logic.dart';

class KmToMilesConverterWidget extends StatelessWidget {
  final DistanceConverterLogic converterLogic = DistanceConverterLogic();
  final TextEditingController kmController = TextEditingController();
  final TextEditingController milesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: kmController,
            decoration: InputDecoration(labelText: 'Километры'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              double km = double.tryParse(kmController.text) ?? 0;
              double miles = converterLogic.convertKmToMiles(km);
              milesController.text = miles.toStringAsFixed(2);
            },
            child: Text('Конвертировать'),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: milesController,
            decoration: InputDecoration(labelText: 'Мили'),
            keyboardType: TextInputType.number,
            readOnly: true,
          ),
        ],
      ),
    );
  }
}
