import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter1/tipo_usuario/tipo_usuario.dart';
import 'package:flutter1/services/caida_services.dart';
import 'package:flutter1/widgets/pantalla2_registrar.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/widgets/pantalla7_borrar_medicamento.dart';
import 'package:flutter1/widgets/pantalla8_configuracion.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class Pantalla1_Inicio extends StatefulWidget {
  

  const Pantalla1_Inicio({super.key});

  @override
  State<Pantalla1_Inicio> createState() => nameState();
}

class nameState extends State<Pantalla1_Inicio> {
  

  BDHelper bdHelper = BDHelper();
  TextEditingController usuarioController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();
  //variables que quiero utilizar en otras pantallas
  static int id=0;
  static String nombre="";
  final int bufferSize = 100;

  //Buffer para almacenar los datos del giroscopio
  List<Map<String,dynamic>> gyroscopeBuffer = [];
  //Buffer para almacenar los datos del acelerometro
  List<Map<String,dynamic>> accelerationBuffer = [];

  //Variables para almacenar los datos del giroscopio
  GyroscopeEvent? _eventoGiroscopio;
  //Variables para almacenar los datos del acelerometro
  AccelerometerEvent? _accelerometerEvent;

  bool hayCaida = false;
  
  //Lista para almacenar los datos de las multiples suscripciones a los sensores
  final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  @override
  void initState() {
    super.initState();
    
    //Añadimos las suscripciones a los sensores
    _streamSubscriptions.add(
      gyroscopeEventStream(
        //frecuencia de muestreo de 100ms
        samplingPeriod: Duration(milliseconds: 100)
        ).listen((GyroscopeEvent event) {
      
      //Cada vez que se recibe un dato del giroscopio se añade al buffer, 
      //si el buffer supera el tamaño maximo se elimina el primer dato
      setState(() {
        _eventoGiroscopio = event;
        gyroscopeBuffer.add(
          {
            "x": event.x,
            "y": event.y,
            "z": event.z,
          });
          if(gyroscopeBuffer.length > bufferSize){
            gyroscopeBuffer.removeAt(0);
          }

      });
    },
    
    ));
    _streamSubscriptions.add(
      accelerometerEventStream(samplingPeriod: Duration(milliseconds: 100)).listen(
        (AccelerometerEvent event) {
          setState(() {
            _accelerometerEvent = event;
            //una caida se produciría cuando el valor de la aceleración en el eje z supera el valor de 10
            accelerationBuffer.add(
              {
                "x": event.x,
                "y": event.y,
                "z": event.z,
              });
            //si el buffer supera el tamaño maximo se elimina el primer dato
            if(accelerationBuffer.length > bufferSize){
              accelerationBuffer.removeAt(0);
            }
            //si el valor de la aceleración en el eje z supera el valor de 10 se muestra una notificación
            if(event.z > 10){
              mostrarNotification("Emergencia", "Se ha detectado una caida");
              hayCaida = true;
            }
          }); 
        },
        
      ),
    );
    
  }

  @override
  void dispose() {
      super.dispose();
      for (final subscription in _streamSubscriptions) {
        subscription.cancel();
      }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Center(
          child: Text(
            'MediCareTracker',
            style: TextStyle(
              fontSize: 24,
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'Arial',
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Usuario',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sans-serif',
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 200,
                    height: 40,
                    color: Colors.grey[300],
                    child: TextField(
                      controller: usuarioController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text(
                    'Contraseña',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sans-serif',
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 200,
                    height: 40,
                    color: Colors.grey[300],
                    child: TextField(
                      controller: contrasenaController,
                      obscureText: true,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 33, 33, 214),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 12.0,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    String usuario = usuarioController.text;
                    String contrasena = contrasenaController.text;

                    if (usuario.isEmpty && contrasena.isEmpty) {//se esta vacio
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Erro"),
                            content: Text(
                              "Por favor, completa el campo de usuario y contraseña.",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sans-serif',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    if (usuario.isEmpty) {//si solo usuario esta vacio
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Erro"),
                            content: Text(
                              "Por favor, completa el campo de usuario.",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sans-serif',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    if (contrasena.isEmpty) {//si solo contraseña esta vacia
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Erro"),
                            content: Text(
                              "Por favor, completa el campo de contraseña.",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Sans-serif',
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    List<Map<String, dynamic>> resultado =
                        await bdHelper.consultarSQL(
                      "SELECT id FROM Usuario WHERE nombre = '$usuario' AND contrasena = '$contrasena'",
                    );
                

                    if (resultado.isNotEmpty) {
                      id = resultado[0]['id'];
                      print('ID de Usuario: $id');
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setString('minhaVariavel', 'id');
                      id = resultado[0]['id'];
                      print('ID de Usuario: $nombre');
                      final prefs2 = await SharedPreferences.getInstance();
                      prefs.setString('minhaVariavel2', 'nombre');

                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Pantalla3_usuario(),
                        ),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error de Autenticación"),
                            content: Text(
                              "Credenciales incorrectas. Inténtalo de nuevo.",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pink,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 233, 83, 208),
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 6.0,
                    shadowColor: Color.fromARGB(255, 33, 33, 214),
                  ),
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(
                      color: Color.fromARGB(255, 227, 227, 235),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sans-serif',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 33, 33, 214),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 12.0,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pantalla2_Registrar(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 233, 83, 208),
                    padding: EdgeInsets.all(16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 6.0,
                    shadowColor: Color.fromARGB(255, 33, 33, 214),
                  ),
                  child: Text(
                    'REGISTRAR',
                    style: TextStyle(
                      color: Color.fromARGB(255, 227, 227, 235),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Sans-serif',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                '¿No tienes cuenta? Pulse "REGISTRAR"',
                style: TextStyle(fontSize: 16),
              ),
              (hayCaida) ? ElevatedButton(
                  onPressed: ()async {await llamaEmergencias();}, //Asignamos la funcion llamaEmergencias al boton
                  style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          onPrimary: Colors.white,
                          onSurface: Colors.grey,
                  ),
                  child: Text(
                            'Avisar a Emergencias',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                  ),))  : Text('No hay caída'),
            ],
          ),
        ),
      ),
    );
  } 
  
}
