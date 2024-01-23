import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/models/visitas_medicas.dart';

class PaginaVisitaMedica extends StatefulWidget {
  const PaginaVisitaMedica({super.key});

  @override
  State<PaginaVisitaMedica> createState() => _PaginaVisitaMedicaState();
}

class _PaginaVisitaMedicaState extends State<PaginaVisitaMedica> {
  VisitaMedica visitaMedica = new VisitaMedica();
  final _formKey = GlobalKey<FormState>();
  BDHelper bdHelper = BDHelper();
    String? selectedConsulta;
    String? selectedDoctor;
    String? selectedFecha;
    String? selectedHora;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Obligamos a quitar el teclado cuando se toque fuera del TextField
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(15),
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Especialidad',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans-serif',
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 250,
                      height: 40,
                      color: Colors.grey[300],
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'El campo no puede estar vacío';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (valor) {
                          if (valor != null) {
                            visitaMedica.especialidad = valor;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ingrese la especialidad médica.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nombre del doctor',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans-serif',
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 250,
                      height: 40,
                      color: Colors.grey[300],
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'El campo no puede estar vacío';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (valor) {
                          if (valor != null) {
                            visitaMedica.doctor = valor;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ingrese el nombre del doctor.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fecha consulta',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans-serif',
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 250,
                      height: 40,
                      color: Colors.grey[300],
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'El campo no puede estar vacío';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (valor) {
                          if (valor != null) {
                            visitaMedica.doctor = valor;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ingrese la fecha.Formato 00/00/0000',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                 SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hora --:--',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Sans-serif',
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      width: 250,
                      height: 40,
                      color: Colors.grey[300],
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'El campo no puede estar vacío';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (valor) {
                          if (valor != null) {
                            visitaMedica.doctor = valor;
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Ingrese la hora.Formato --:--',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 60),
                
                ElevatedButton(
                  
                  onPressed: () {
                    
                    if (_formKey.currentState!.validate()) {
                      
                      _formKey.currentState!.save();
                      bdHelper.insertarBD('VisitaMedica', visitaMedica.toMap());
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 233, 83, 208),
                  ),
                  child: Text('Guardar'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 233, 83, 208),
                  ),
                  child: Text('Salir'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
