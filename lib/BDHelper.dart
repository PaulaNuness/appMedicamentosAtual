import 'package:flutter/material.dart';
import 'package:flutter1/models/medicamento.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


  // é um helper para interagir com um banco de dados SQLite no Flutter.
  class BDHelper{
    static Database? _baseDatos;//é uma instância estática da classe Database que representa a conexão com o banco de dados.
    static const String nombreBD = "BDME.db";// é o nome do arquivo do banco de dados SQLite


  Future<Database?> get baseDatos async {
    if (_baseDatos != null) {
      return _baseDatos;
    }
    _baseDatos = await _inicializarBD();
    return _baseDatos;
  }

  Future<List<Map<String, dynamic>>> consultarBD(String tabla) async {
    Database? bd = await baseDatos;
    var resultado = await bd!.query(tabla);
    return resultado;
  }

  Future<List<Map<String, dynamic>>> consultarSQL(String sql) async {
    Database? bd = await baseDatos;
    var resultado = await bd!.rawQuery(sql);
    return resultado;
  }

  Future<int> insertarBD(String tabla, Map<String, dynamic> fila) async {
    Database? bd = await baseDatos;
    var resultado = await bd!.insert(tabla, fila);
    return resultado;
  }

  Future<int> eliminarBD(String tabla, int id) async {
    Database? bd = await baseDatos;
    var resultado =
        await bd!.delete(tabla, where: 'id = ?', whereArgs: [id]);
    return resultado;
  }

  Future<int> actualizarBD(String tabla, Map<String, dynamic> fila) async {
    Database? bd = await baseDatos;
    var resultado = 0;
    if (bd != null) {
      resultado = await bd.update(tabla, fila,
          where: 'id = ?', whereArgs: [fila['id']]);
    }

    return resultado;
  }

  Future<List<Map<String, dynamic>>> consultarMedicamentos(int idusuario) async {
    Database? bd = await baseDatos;
    var resultado = await bd!.query(
      'Medicamento',
      where: 'idusuario = ?',
      whereArgs: [idusuario],
    );
    return resultado;
  }

  Future<List<Map<String, dynamic>>> consultarVisitas() async {
    Database? bd = await baseDatos;
    var resultado = await bd!.query('VisitaMedica');
    return resultado;
  }

  Future<void> borrarMedicamento(int id) async {
    Database? bd = await baseDatos;
    await bd!.delete('Medicamento', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> decrementarQuantidadeMedicamento(int idMedicamento) async {
    var medicamento = await _baseDatos!.query('Medicamento',
        where: 'id = ?', whereArgs: [idMedicamento]);
    if (medicamento.isNotEmpty) {
      var quantidadeAtual = medicamento.first['quantidade'] as int;
      var quantidadeEnvaseAtual =
          medicamento.first['quantidadeEnvase'] as int;

      if (quantidadeAtual > 0 && quantidadeEnvaseAtual > 0) {
        await _baseDatos!.update(
          'Medicamento',
          {
            'quantidade': quantidadeAtual - 1,
            'quantidadeEnvase': quantidadeEnvaseAtual - 1,
          },
          where: 'id = ?',
          whereArgs: [idMedicamento],
        );
      }
    }
  }

  _inicializarBD() async {
    var directorio = await getDatabasesPath();
    String path = directorio + nombreBD;
    var baseDatos = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS Usuario(id INTEGER PRIMARY KEY, nombre TEXT, contrasena TEXT, fechanacimento TEXT, sexo TEXT)",
        );
        await db.execute(
          "CREATE TABLE if not exists Medicamento(id INTEGER PRIMARY KEY,idUsuario INTEGER, nome TEXT,quantidade INTEGER, unidadeTempo TEXT,quantidadeEnvase INTEGER,recomendacoes TEXT,horarios TEXT  )",
        );
        await db.execute(
          "CREATE TABLE IF NOT EXISTS VisitaMedica(id INTEGER PRIMARY KEY, idUsuario INTEGER,especialidad TEXT, doctor TEXT, lugar TEXT, fecha TEXT)",
        );
      },
    );
    return baseDatos;
  }
}
