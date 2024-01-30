import 'package:flutter/material.dart';
import 'package:flutter1/modo/modo_trabajo.dart';
import 'package:flutter1/tema/tema.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';
import 'package:provider/provider.dart';


void main() {
 runApp(
    //Cargamos en el nivel más alto de la aplicación el provider
    //En dicho provider cargamos el tema actual
    MultiProvider(
      providers: [
          ChangeNotifierProvider(
          //cargamos el tema claro por defecto
          create: (_) => CargadorTema(0)),
          ChangeNotifierProvider(
          //cargamos el modo de funcionamiento por defecto
          create: (_) => ModoTrabajo()), 
          
      ],
      child: MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    //cargamos el tema actual del provider
    final temaActual=Provider.of<CargadorTema>(context).temaActual;
    
    return MaterialApp(
      title: 'Medicame',
      theme: temaActual,
      home:  Pantalla1_Inicio(),
    );
  }
}


