import 'package:flutter/material.dart';
import 'screens/checklist_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checklist de Avaliação Ambiental',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChecklistFormScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
