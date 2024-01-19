import 'package:flutter/material.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Pantalla1_Inicio(),
    );
  }
}
