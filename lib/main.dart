import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(SpinWheelApp());
}

class SpinWheelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lucky Decision',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SpinWheelPage(),
    );
  }
}

class SpinWheelPage extends StatefulWidget {
  @override
  _SpinWheelPageState createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage> {
  TextEditingController optionController = TextEditingController();
  FocusNode optionFocusNode = FocusNode();
  List<String> options = [];
  String selectedOption = '';
  bool spinning = false;

  @override
  void initState() {
    super.initState();
  }

  void spinWheel() {
    setState(() {
      spinning = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      final random = Random();
      final index = random.nextInt(options.length);
      setState(() {
        selectedOption = options[index];
        spinning = false;
      });
    });
  }

  void addOption() {
    if (optionController.text.isNotEmpty) {
      setState(() {
        options.add(optionController.text);
        optionController.clear();
      });
      FocusScope.of(context).requestFocus(optionFocusNode);
    }
  }

  void clearData() {
    setState(() {
      options.clear();
      selectedOption = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lucky Decision'),
      ),
      body: Container(
        color: Colors.orange,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Seçenekleri Girin:',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: optionController,
              focusNode: optionFocusNode,
              onSubmitted: (_) => addOption(),
              decoration: InputDecoration(
                hintText: 'Seçeneği Girin',
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              child: Text('Seçeneği Ekle', style: TextStyle(color: Colors.black)),
              onPressed: addOption,
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
            ),
            SizedBox(height: 32.0),
            Text(
              'Seçilen Değer:',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.purple,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                selectedOption,
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
            SizedBox(height: 32.0),
            TextButton(
              child: Text('Çevir', style: TextStyle(color: Colors.black)),
              onPressed: spinning || options.isEmpty ? null : spinWheel,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
            ),
            SizedBox(height: 16.0),
            TextButton(
              child: Text('Verileri Temizle', style: TextStyle(color: Colors.black)),
              onPressed: options.isEmpty ? null : clearData,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
