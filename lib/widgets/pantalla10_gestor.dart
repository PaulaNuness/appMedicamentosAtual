import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';

class Pantalla10_gestor extends StatefulWidget {
  @override
  _Pantalla10_gestorState createState() => _Pantalla10_gestorState();
}

class _Pantalla10_gestorState extends State<Pantalla10_gestor> {
  BDHelper bdHelper = BDHelper();
  List<Map<String, dynamic>> usuarios = [];

  @override
  void initState() {
    super.initState();
    _carregarUsuarios();
  }

  Future<void> _carregarUsuarios() async {
    List<Map<String, dynamic>> result =
        await bdHelper.consultarSQL('SELECT * FROM Usuario');
    setState(() {
      usuarios = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[300],
            title: Center(
              child: Text(
                'Lista de Usuarios',
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
      body: _buildListaUsuarios(),
    );
  }

  Widget _buildListaUsuarios() {
    if (usuarios.isEmpty) {
      return Center(
        child: Text('Nenhum usuário encontrado.'),
      );
    } else {
      return ListView.builder(
        itemCount: usuarios.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('ID: ${usuarios[index]['id']}'),
            subtitle: Text('Nome: ${usuarios[index]['nombre']}'),
          );
        },
      );
    }
  }
}

