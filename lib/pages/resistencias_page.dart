import 'package:flutter/material.dart';

class ResistenciasPage extends StatefulWidget {
  const ResistenciasPage({super.key});

  @override
  State<ResistenciasPage> createState() => _ResistenciasPageState();
}

class _ResistenciasPageState extends State<ResistenciasPage> {
  int bandCount = 4;

  final Map<String, int> colorValues = {
    'Negro': 0,
    'Marrón': 1,
    'Rojo': 2,
    'Naranja': 3,
    'Amarillo': 4,
    'Verde': 5,
    'Azul': 6,
    'Violeta': 7,
    'Gris': 8,
    'Blanco': 9,
  };

  final Map<String, double> multiplierValues = {
    'Negro': 1,
    'Marrón': 10,
    'Rojo': 100,
    'Naranja': 1000,
    'Amarillo': 10000,
    'Verde': 100000,
    'Azul': 1000000,
    'Violeta': 10000000,
    'Gris': 100000000,
    'Blanco': 1000000000,
    'Dorado': 0.1,
    'Plateado': 0.01,
  };

  final Map<String, String> toleranceValues = {
    'Marrón': '±1%',
    'Rojo': '±2%',
    'Dorado': '±5%',
    'Plateado': '±10%',
  };

  String band1 = 'Marrón';
  String band2 = 'Negro';
  String band3 = 'Negro';
  String multiplier = 'Marrón';
  String tolerance = 'Dorado';
  String result = '';

  void calculateResistance() {
    int firstDigit = colorValues[band1]!;
    int secondDigit = colorValues[band2]!;
    int thirdDigit = colorValues[band3]!;

    double resistanceValue = 0;

    if (bandCount == 4) {
      resistanceValue =
          ((firstDigit * 10) + secondDigit) * multiplierValues[multiplier]!;
    } else {
      resistanceValue = ((firstDigit * 100) +
          (secondDigit * 10) +
          thirdDigit) *
          multiplierValues[multiplier]!;
    }

    String formattedResistance;
    if (resistanceValue >= 1000000) {
      formattedResistance = '${(resistanceValue / 1000000).toStringAsFixed(2)} MΩ';
    } else if (resistanceValue >= 1000) {
      formattedResistance = '${(resistanceValue / 1000).toStringAsFixed(2)} KΩ';
    } else {
      formattedResistance = '${resistanceValue.toStringAsFixed(2)} Ω';
    }

    setState(() {
      result = '$formattedResistance ${toleranceValues[tolerance]}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculadora de Resistencias')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<int>(
              value: bandCount,
              onChanged: (value) {
                setState(() {
                  bandCount = value!;
                });
              },
              items: [4, 5, 6].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value bandas'),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildDropdown('Banda 1', band1, (value) => setState(() => band1 = value)),
                buildDropdown('Banda 2', band2, (value) => setState(() => band2 = value)),
                if (bandCount >= 5)
                  buildDropdown('Banda 3', band3, (value) => setState(() => band3 = value)),
              ],
            ),
            buildDropdown('Multiplicador', multiplier, (value) => setState(() => multiplier = value)),
            buildDropdown('Tolerancia', tolerance, (value) => setState(() => tolerance = value)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateResistance,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 20),
            Text(
              result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropdown(String label, String currentValue, Function(String) onChanged) {
    List<String> options = [];

    if (label.startsWith('Banda')) {
      options = colorValues.keys.toList();
    } else if (label == 'Multiplicador') {
      options = multiplierValues.keys.toList();
    } else if (label == 'Tolerancia') {
      options = toleranceValues.keys.toList();
    }

    return Column(
      children: [
        Text(label),
        DropdownButton<String>(
          value: currentValue,
          onChanged: (value) => onChanged(value!),
          items: options.map((String color) {
            return DropdownMenuItem<String>(
              value: color,
              child: Text(color),
            );
          }).toList(),
        ),
      ],
    );
  }
}
