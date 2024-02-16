import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';
import 'package:flutter1/widgets/pantalla4_anadir.dart';
import 'package:flutter1/widgets/pantalla6_agenda_medicamientos.dart';

class pantalla5_lista_medicamientos extends StatefulWidget {
  @override
  _MedicamentosScreenState createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<pantalla5_lista_medicamientos> {
  int _selectedIndex = 0;
  BDHelper bdHelper = BDHelper();
  List<Map<String, dynamic>> medicamentosAReponer = [];
  int minhavariavel = nameState.id;

  @override
  void initState() {
    super.initState();
    _carregarMedicamentos();
  }

  Future<void> _carregarMedicamentos() async {
    List<Map<String, dynamic>> medicamentos =
        await bdHelper.consultarMedicamentos(minhavariavel);

    setState(() {
      medicamentosAReponer = medicamentos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: false, // Remover a seta de voltar
        title: Center(
          child: Text(
            'MEDICAMENTOS',
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
                  '${medicamentosAReponer[index]['quantidade']}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                medicamentosAReponer[index]['nome'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cantidad restante a tomar: ${medicamentosAReponer[index]['quantidade']}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Cantidad envase: ${medicamentosAReponer[index]['quantidadeEnvase']}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Recomendaciones: ${medicamentosAReponer[index]['recomendacoes']}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Horarios: ${medicamentosAReponer[index]['horarios']}',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Añadir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Lista',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          if (_selectedIndex == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Pantalla3_usuario(),
              ),
            );
          }
          if (_selectedIndex == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Pantalla4_Anadir(),
              ),
            );
          }
          if (_selectedIndex == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AgendaMedicamentos(),
              ),
            );
          }
          if (_selectedIndex == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => pantalla5_lista_medicamientos(),
              ),
            );
          }
        },
        selectedItemColor: Colors.pink,
        unselectedItemColor: const Color.fromARGB(255, 228, 184, 198),
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
                    color: Color.fromARGB(255, 233, 83, 208),
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
