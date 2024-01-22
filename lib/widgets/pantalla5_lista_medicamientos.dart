import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:sqflite/sqflite.dart';

class pantalla5_lista_medicamientos extends StatefulWidget {
  @override
  _MedicamentosScreenState createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<pantalla5_lista_medicamientos> {
  BDHelper bdHelper = BDHelper();
  List<Map<String, dynamic>> medicamentosAReponer = [];

  @override
  void initState() {
    super.initState();
    _carregarMedicamentos();
  }

  Future<void> _carregarMedicamentos() async {
    List<Map<String, dynamic>> medicamentos = await bdHelper.consultarMedicamentos();

    setState(() {
      medicamentosAReponer = medicamentos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Center(
          child: Text(
            'MEDICAMENTOS A REPOR',
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
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 233, 83, 208),
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: medicamentosAReponer.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 233, 83, 208),
                child: Text(
                  '${medicamentosAReponer[index]['quantidade']}',  // Ajuste conforme a estrutura real do seu banco de dados
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                medicamentosAReponer[index]['nome'],  // Ajuste conforme a estrutura real do seu banco de dados
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Quantidade restante: ${medicamentosAReponer[index]['quantidade']}',  // Ajuste conforme a estrutura real do seu banco de dados
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              onTap: () {
                // Navegar para a tela de farmácias mais próximas
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmaciasScreen()),
                );
              },
            );
          },
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color:  Color.fromARGB(255, 233, 83, 208),
              ),
              child: Center(
                child: Text(
                  'Menu Lateral',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Opção 1'),
              onTap: () {
                // Lógica quando a opção 1 é selecionada
                Navigator.pop(context); // Fechar o endDrawer
              },
            ),
            ListTile(
              title: Text('Opção 2'),
              onTap: () {
                // Lógica quando a opção 2 é selecionada
                Navigator.pop(context); // Fechar o endDrawer
              },
            ),
            ListTile(
              title: Text('Opção 2'),
              onTap: () {
                // Lógica quando a opção 2 é selecionada
                Navigator.pop(context); // Fechar o endDrawer
              },
            )
            // Adicione mais ListTile conforme necessário
          ],
        ),
      ),
    );
  }
}

class FarmaciasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> farmacias = [
      'Calle de la Salud 31, 47011, Valladolid',
      '47 Calle Soto, 47010, Valladolid',
      'Calle de la Cebadería 3, 47001, Valladolid',
      'Calle Imperial 5, 47003, Valladolid'
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Center(
          child: Text(
            'FARMACIAS PRÓXIMAS',
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
      body: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(255, 233, 83, 208),
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: farmacias.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(farmacias[index]),
                  Icon(
                    Icons.location_on,
                    color:  Color.fromARGB(255, 233, 83, 208),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
