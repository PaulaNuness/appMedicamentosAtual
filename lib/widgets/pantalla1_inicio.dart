
import 'package:flutter/material.dart';
import 'package:flutter1/widgets/pantalla2_registrar.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';
import 'package:flutter1/BDHelper.dart';

class Pantalla1_Inicio extends StatelessWidget {
  BDHelper bdHelper = BDHelper();
  TextEditingController usuarioController = TextEditingController();
  TextEditingController contrasenaController = TextEditingController();

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
                    'Usuário',
                    style: TextStyle(fontSize: 25),
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
                    style: TextStyle(fontSize: 25),
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

                    if (usuario.isEmpty && contrasena.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Erro"),
                            content: Text("Por favor, preencha o usuário e a senha."),
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
                      return; // Impede a continuação do código se ambos os campos estiverem vazios
                    }

                    if (usuario.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Erro"),
                            content: Text("Por favor, preencha o campo de usuário."),
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
                      return; // Impede a continuação do código se o campo de usuário estiver vazio
                    }

                    if (contrasena.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Erro"),
                            content: Text("Por favor, preencha o campo de senha."),
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
                      return; // Impede a continuação do código se o campo de senha estiver vazio
                    }

                    List<Map<String, dynamic>> resultado = await bdHelper.consultarSQL(
                        "SELECT * FROM Usuario WHERE nombre = '$usuario' AND contrasena = '$contrasena'");

                    if (resultado.isNotEmpty) {
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
                            title: Text("Erro de Autenticação"),
                            content: Text("Credenciais incorretas. Tente novamente."),
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
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 164, 216, 240),
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(
                      color: Color.fromARGB(255, 33, 33, 214),
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
                    primary: const Color.fromARGB(255, 164, 216, 240),
                    padding: EdgeInsets.all(16.0),
                  ),
                  child: Text(
                    'REGISTRAR',
                    style: TextStyle(
                      color: Color.fromARGB(255, 33, 33, 214),
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
            ],
          ),
        ),
      ),
    );
  }
}