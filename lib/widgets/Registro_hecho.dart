import 'package:flutter/material.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';

class RegistroHecho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Muy bien!!! Registro hecho',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
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
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 233, 83, 208),
                  padding: EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), 
                  ),
                  elevation: 6.0,
                  shadowColor: Color.fromARGB(255, 33, 33, 214),
                ),
                child: Text(
                  'SALIR',
                  style: TextStyle(
                    color: Color.fromARGB(255, 227, 227, 235),
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Sans-serif',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
