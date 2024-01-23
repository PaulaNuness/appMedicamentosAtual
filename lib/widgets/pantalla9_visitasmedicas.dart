import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/models/visitamedica.dart';




class PaginaVisitaMedica extends StatefulWidget {
  const PaginaVisitaMedica({super.key});

  @override
  State<PaginaVisitaMedica> createState() => _PaginaVisitaMedicaState();
}

class _PaginaVisitaMedicaState extends State<PaginaVisitaMedica> {

  VisitaMedica visitaMedica = new VisitaMedica();
  final _formKey = GlobalKey<FormState>();
  BDHelper bdHelper = BDHelper();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        //obligamos a quitar el teclado cuando se toque fuera del TextField
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
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Especialidad'),
                ),
              validator: (valor){
                if (valor==null || valor.isEmpty){
                  return 'El campo no puede estar vacio';
                }
                else{
                  return null;
                }
              },
              onSaved: (valor) {
                if(valor!=null)
                {
                  visitaMedica.especialidad = valor;
                }
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Nombre del doctor'),
                ),
                validator: (valor){
                if (valor==null || valor.isEmpty){
                  return 'El campo no puede estar vacio';
                }
                else{
                  return null;
                }
              },
              onSaved: (valor) {
                if(valor!=null)
                {
                  visitaMedica.doctor = valor;
                }
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Lugar de la visita'),
                ),
                validator: (valor){
                if (valor==null || valor.isEmpty){
                  return 'El campo no puede estar vacio';
                }
                else{
                  return null;
                }
              },
              onSaved: (valor) {
                if(valor!=null)
                {
                  visitaMedica.lugar = valor;
                }
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  label: Text('Fecha de la visita'),
                ),
                validator: (valor){
                if (valor==null || valor.isEmpty){
                  return 'El campo no puede estar vacio';
                }
                if(RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').hasMatch(valor)==false)
                {
                  return 'El formato de la fecha no es correcto';
                }
                List<String> partes = valor.split("/");
                int dia = int.tryParse(partes[0])!;
                int mes = int.tryParse(partes[1])!;
                int anio = int.tryParse(partes[2])!;

                try{
                  DateTime fecha = new DateTime(anio, mes, dia);
                }
                catch(e)
                {
                  return 'La fecha no es correcta';
                };
                
                return null;

              },
              onSaved: (valor) {
                if(valor!=null)
                {
                  visitaMedica.dia = valor;
                }
                },
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  label: Text('Hora de la visita'),
                ),
                validator: (valor){
                if (valor==null || valor.isEmpty){
                  return 'El campo no puede estar vacio';
                }
                if(RegExp(r'^[0-2][0-9]:[0-5][0-9]$').hasMatch(valor)==false)
                {
                  return 'El formato de la fecha no es correcto';
                }
                else{
                  return null;
                }
                },
                
              onSaved: (valor) {
                if(valor!=null)
                {
                  visitaMedica.hora = valor;
                }
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        bdHelper.insertarBD('VisitaMedica', visitaMedica.toMap());
                        Navigator.pop(context);
                      }
                    },
                child: Text('Guardar')),
                              ElevatedButton(
                onPressed: () {
                      if (_formKey.currentState!.validate()) {

                        Navigator.pop(context);
                      }
                    },
                child: Text('Salir')),
            ],
          ),
        ),
      )),
    );
  }
}