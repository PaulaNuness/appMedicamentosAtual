  import 'package:flutter/material.dart';
  import 'package:flutter1/models/medicamento.dart';
  import 'package:sqflite/sqflite.dart';
  import 'package:path/path.dart';

  // é um helper para interagir com um banco de dados SQLite no Flutter.
  class BDHelper{
    static Database? _baseDatos;//é uma instância estática da classe Database que representa a conexão com o banco de dados.
    static const String nombreBD = "BDMedicamentos.db";// é o nome do arquivo do banco de dados SQLite.

    //iniciar la base de datos
    Future<Database?> get baseDatos async{//é um getter assíncrono que retorna a instância do banco de dados. Se a instância _baseDatos já estiver inicializada, ela é retornada imediatamente
      if(_baseDatos != null){
        return _baseDatos;
      }
      _baseDatos = await _inicializarBD();//Caso contrário, _inicializarBD() é chamado para inicializar o banco de dados e, em seguida, a instância é retornada
      return _baseDatos;
    }

    //consultar la tabla entera en la base de datos
    Future<List<Map<String, dynamic>>> consultarBD(String tabla) async{//é um método assíncrono que aceita o nome de uma tabela como parâmetro e retorna uma lista de mapas representando os registros da tabela
      Database? bd = await baseDatos;
      var resultado = await bd!.query(tabla);
      return resultado;
    }

    //consulta con sql
    Future<List<Map<String, dynamic>>> consultarSQL(String sql) async{//é um método assíncrono que aceita uma consulta SQL como parâmetro e retorna os resultados como uma lista de mapas
      Database? bd = await baseDatos;
      var resultado = await bd!.rawQuery(sql);
      return resultado;
    }

    //insertar datos en la base de datos
    Future<int> insertarBD(String tabla, Map<String, dynamic> fila) async{//é um método assíncrono que aceita o nome de uma tabela e um mapa representando uma linha de dados a ser inserida. Retorna o número de linhas afetadas pela operação de inserção
      Database? bd = await baseDatos;
      var resultado = await bd!.insert(tabla, fila);
      return resultado;
    }

    //eliminar datos de la base de datos
    Future<int> eliminarBD(String tabla, int id) async{//é um método assíncrono que aceita o nome de uma tabela e um ID como parâmetros e retorna o número de linhas afetadas pela operação de exclusão.
      Database? bd = await baseDatos;
      var resultado = await bd!.delete(tabla, where: 'id = ?', whereArgs: [id]);
      return resultado;
    }

    //actualizar datos de la base de datos
    Future<int> actualizarBD(String tabla, Map<String, dynamic> fila) async{//é um método assíncrono que aceita o nome de uma tabela e um mapa representando uma linha de dados a ser atualizada. Retorna o número de linhas afetadas pela operação de atualização
      Database? bd = await baseDatos;
      var resultado=0;
      if (bd!=null)
      {
        resultado = await bd.update(tabla, fila, where: 'id = ?', whereArgs: [fila['id']]);
      }
      
      return resultado;
    }


    // Consultar a tabela 'Medicamento' na base de dados
    Future<List<Map<String, dynamic>>> consultarMedicamentos() async {
      Database? bd = await baseDatos;
      var resultado = await bd!.query('Medicamento');
      return resultado;
    }

    
    Future<void> borrarMedicamento(int id) async {
      Database? bd = await baseDatos;
      await bd!.delete('Medicamento', where: 'id = ?', whereArgs: [id]);
    }


  Future<void> decrementarQuantidadeMedicamento( int idMedicamento) async {
    var medicamento = await _baseDatos!.query('Medicamento', where: 'id = ?', whereArgs: [idMedicamento]);
    if (medicamento.isNotEmpty) {
      var quantidadeAtual = medicamento.first['quantidade'] as int;
      var quantidadeEnvaseAtual = medicamento.first['quantidadeEnvase'] as int;

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





    _inicializarBD() async{//é um método privado que é chamado internamente para inicializar o banco de dados SQLite
      var directorio = await getDatabasesPath();//obtém o caminho do diretório de bancos de dados.
      String path = directorio + nombreBD;// cria o caminho completo para o arquivo do banco de dados.
      var baseDatos = await openDatabase(//abre ou cria o banco de dados SQLite
        path, 
        version: 1, 
        onCreate: (Database db, int version) async{
          await db.execute(//cria a tabela usuario se ainda nao existe
            "CREATE TABLE IF NOT EXISTS Usuario(id INTEGER PRIMARY KEY, nombre TEXT, contrasena TEXT, fechanacimento TEXT, sexo TEXT)"
          );
          //para añadir una segunda tabla
          await db.execute(
            "CREATE TABLE if not exists Medicamento(id INTEGER PRIMARY KEY, nome TEXT,quantidade INTEGER, unidadeTempo TEXT,quantidadeEnvase INTEGER,recomendacoes TEXT,horarios TEXT  )"
          );
          //para añadir una teceratabla
          await db.execute(
            "CREATE TABLE if not exists VisitaMedica(id INTEGER PRIMARY KEY, especialidad TEXT, doctor TEXT, fecha TEXT,hora TEXT  )"
            
          );
        }
        );
      return baseDatos;
    }
  }
