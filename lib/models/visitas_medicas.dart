import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:provider/provider.dart';

class VisitaMedica{
  int? _id;
  late String _especialidad;
  late String _doctor;
  late String _fecha;
  late String _hora;

  //Constructor de la clase
  VisitaMedica()
  {
    this._id = 0;
    this._especialidad = '';
    this._doctor = '';
    this._fecha = '';
    this._hora = '';
  }
  
  //Constructores con parametros
  VisitaMedica.withOutId(String especialidad, String doctor, String fecha, String hora)
  {
    this._especialidad = especialidad;
    this._doctor = doctor;
    this._fecha = fecha;
    this._hora = hora;
  }
  
  VisitaMedica.withId(int id, String especialidad, String doctor, String fecha, String hora)
  {
    this._id = id;
    this._especialidad = especialidad;
    this._doctor = doctor;
    this._fecha = fecha;
    this._hora = hora;
  }

  VisitaMedica.fromMap(dynamic obj)
  {
    this._id = obj['id'];
    this._especialidad = obj['especialidad'];
    this._doctor = obj['doctor'];
    this._fecha = obj['fecha'];
    this._hora = obj['hora'];

  }

  //Getters
  int? get id => _id;
  String get especialidad => _especialidad;
  String get doctor => _doctor;
  String get fecha => _fecha;
  String get hora => _hora;
  
  //Setters
  set especialidad(String especialidad)
  {
    this._especialidad = especialidad;
  }
  set doctor(String doctor)
  {
    this._doctor = doctor;
  }

  set fecha(String fecha)
  {
    this._fecha = fecha;

  }

  set hora(String hora)
  {
    this._hora = hora;

  }

  Future<List<VisitaMedica>> GeTProximasVisitas(bool modoLocal)
  async{
    List<VisitaMedica> proximasVisitas = [];
    VisitaMedica visitaMedica = new VisitaMedica();
    DateTime fechaActual = DateTime.now();
    
    //Si el modo de trabajo es local, se cargan los datos de la base de datos local
    if(modoLocal)
    {
      BDHelper bdHelper = BDHelper();
      List<Map<String, dynamic>> visitas = await bdHelper.consultarBD('VisitaMedica');
      for(int i=0; i<visitas.length; i++)
      {
        DateTime fechaVisita = DateTime.parse(visitas[i]['fecha']);
        if(fechaVisita.isAfter(fechaActual))
        {
          visitaMedica = VisitaMedica.fromMap(visitas[i]);
          proximasVisitas.add(visitaMedica);
        }
      }
    }
    else
    {
      //Si el modo de trabajo es remoto, se cargan los datos de la API
      proximasVisitas = await _getFromAPI(10);
    }
    
    return proximasVisitas;
  }

  //lectura de datos de la API
  Future<List<VisitaMedica>> _getFromAPI(int numero) async {

    List<VisitaMedica> lista = [];
    VisitaMedica visitaMedica = new VisitaMedica();
    var map = new Map<String, dynamic>();
    
    for(int i=0;i<numero;i++)
    {
      await Future.delayed(Duration(milliseconds: 200), () {
        map['id'] = i;
        map['especialidad'] = 'Especialidad '+i.toString();
        map['doctor'] = 'Doctor '+i.toString();
        map['lugar'] = 'Lugar '+i.toString();
        map['fecha'] = DateTime.now().toString();
        visitaMedica = VisitaMedica.fromMap(map);
        lista.add(visitaMedica);
      });
    }
    return lista;
  }

  //Metodo para convertir un objeto de tipo VisitaMedica a Map
  Map<String, dynamic> toMap()
  {
    var map = new Map<String, dynamic>();
    if((id != null && id != 0))
    {
      map['id'] = _id;
    }
    map['especialidad'] = _especialidad;
    map['doctor'] = _doctor;
    map['fecha'] = _fecha.toString();
    return map;
  }

}