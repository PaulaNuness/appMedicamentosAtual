  import 'package:flutter/material.dart';
  import 'package:flutter1/BDHelper.dart';
  import 'package:flutter1/models/usuario.dart';
  import 'package:flutter1/widgets/Registro_hecho.dart';

  class Pantalla2_Registrar extends StatefulWidget {
    @override
    _Pantalla2_RegistrarState createState() => _Pantalla2_RegistrarState();
  }

  class _Pantalla2_RegistrarState extends State<Pantalla2_Registrar> {
    BDHelper bdHelper = BDHelper();

    TextEditingController nombreController = TextEditingController();
    TextEditingController contrasenaController = TextEditingController();
    TextEditingController fechaNacimientoController = TextEditingController();
    TextEditingController sexoController = TextEditingController();

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[300],
            title: Center(
              child: Text(
                'Hola, bienvenido.',
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
                  Column(
                    children: [
                      Text(
                        'Nombre',
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                              fontFamily: 'Sans-serif',),
                        
                      ),
                      
                      SizedBox(height: 4),
                      Container(
                        width: 250,
                        height: 40,
                        color: Colors.grey[300],
                        child: TextField(
                          controller: nombreController,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Column(
                    children: [
                      Text(
                        'Contraseña',
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                              fontFamily: 'Sans-serif',),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 250,
                        height: 40,
                        color: Colors.grey[300],
                        child: TextField(
                          controller: contrasenaController,
                          obscureText: true,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'La contraseña debe contener solo números y letras.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Column(
                    children: [
                      Text(
                        'Fecha Nacimiento',
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                              fontFamily: 'Sans-serif',),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 250,
                        height: 40,
                        color: Colors.grey[300],
                        child: TextField(
                          controller: fechaNacimientoController,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Formato: 00/00/0000',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  Column(
                    children: [
                      Text(
                        'Sexo',
                        style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                              fontFamily: 'Sans-serif',),
                      ),
                      SizedBox(height: 4),
                      Container(
                        width: 250,
                        height: 40,
                        color: Colors.grey[300],
                        child: TextField(
                          controller: sexoController,
                        ),
                      ),
                      SizedBox(height: 4),
                      if (!_isSexValid(sexoController.text))
                      Text(
                        'Formato: Hombre o Mujer',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 90),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 150,
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
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 233, 83, 208),
                      padding: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Ajuste o valor conforme necessário
                      ),
                      elevation: 6.0,
                      shadowColor: Color.fromARGB(255, 33, 33, 214),
                    ),
                          child: Text(
                            'SALIR',
                            style: TextStyle(
                              color: Color.fromARGB(255, 227, 227, 235),
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sans-serif',
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
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
                            String nombre = nombreController.text;
                            String contrasena = contrasenaController.text;
                            String fechaNacimiento =
                                fechaNacimientoController.text;
                            String sexo = sexoController.text;

                            if (nombre.isEmpty ||
                                contrasena.isEmpty ||
                                fechaNacimiento.isEmpty ||
                                sexo.isEmpty) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                      "Por favor, complete todos los campos.",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.pink,),)
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }

                            if (!_isDateValid(fechaNacimientoController.text) ||
                                !_isMonthValid(fechaNacimientoController.text) ||
                                !_isYearValid(fechaNacimientoController.text)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                      "Fecha de nacimiento no válida.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }

                            if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(contrasena)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                      "La contraseña debe contener solo números y letras.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }

                            if (!_isSexValid(sexo)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text(
                                      'Sexo no válido. Utilice "hombre", "mujer"',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                              return;
                            }

                            Usuario usuario = Usuario.withoutId(
                              nombre,
                              contrasena,
                              fechaNacimiento,
                              sexo,
                            );

                            int resultado = await bdHelper.insertarBD(
                              'Usuario',
                              usuario.toMap(),
                            );

                            if (resultado > 0) {
                              print('Datos insertados con éxito:');
                              print('ID: ${usuario.id}');
                              print('Nombre: $nombre');
                              print('Contraseña: $contrasena');
                              print('Fecha de Nacimiento: $fechaNacimiento');
                              print('Sexo: $sexo');
                            } else {
                              print('Error al insertar datos.');
                            }

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistroHecho(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 233, 83, 208),
                      padding: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Ajuste o valor conforme necessário
                      ),
                      elevation: 6.0,
                      shadowColor: Color.fromARGB(255, 33, 33, 214),
                    ),
                          child: Text(
                            'REGISTRAR',
                            style: TextStyle(
                              color: Color.fromARGB(255, 227, 227, 235),
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Sans-serif',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    bool _isDateValid(String date) {
      RegExp regex =
          RegExp(r'^([1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$');
      return regex.hasMatch(date);
    }

    bool _isMonthValid(String date) {
      List<String> dateParts = date.split('/');
      if (dateParts.length == 3) {
        try {
          int month = int.parse(dateParts[1]);
          return month >= 1 && month <= 12;
        } catch (e) {
          return false;
        }
      }
      return false;
    }

    bool _isYearValid(String date) {
      List<String> dateParts = date.split('/');
      if (dateParts.length == 3) {
        try {
          int year = int.parse(dateParts[2]);
          return year >= 1900 && year <= 2100;
        } catch (e) {
          return false;
        }
      }
      return false;
    }

    bool _isSexValid(String sex) {
      return ['hombre', 'mujer'].contains(sex.toLowerCase());
    }
  }
