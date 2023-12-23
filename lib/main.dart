import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String result = '';
  String healthStatus = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(
          'BMI Calculator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox(height: 20),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Height (cm)',
                fillColor: Colors.grey[200],
                filled: true,
                icon: Icon(Icons.height), // Add an icon for height
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Weight (kg)',
                fillColor: Colors.grey[200],
                filled: true,
                icon: Icon(Icons.fitness_center), // Add an icon for weight
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey[900], // Set button color
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Calculate BMI',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Result: $result',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Health Status: $healthStatus',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    double height = double.tryParse(heightController.text) ?? 0.0;
    double weight = double.tryParse(weightController.text) ?? 0.0;

    if (height > 0 && weight > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      setState(() {
        result = 'BMI: ${bmi.toStringAsFixed(2)}';
        healthStatus = getHealthStatus(bmi);
      });
    } else {
      setState(() {
        result = 'Invalid input. Please enter valid values.';
        healthStatus = '';
      });
    }
  }

  String getHealthStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight: Health risk = Minimal';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Normal: Health risk = Minimal';
    } else if (bmi >= 25 && bmi <= 29.9) {
      return 'Overweight: Health risk = Slightly Increased';
    } else if (bmi >= 30 && bmi <= 34.9) {
      return 'Obese: Health risk = High';
    } else if (bmi >= 35 && bmi <= 39.9) {
      return 'Severely Obese: Health risk = Very High';
    } else {
      return 'Morbidly Obese: Health risk = Extremely High';
    }
  }
}
