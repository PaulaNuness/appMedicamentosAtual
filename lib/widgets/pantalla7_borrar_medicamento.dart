import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';
import 'package:flutter1/widgets/pantalla4_anadir.dart';
import 'package:flutter1/widgets/pantalla5_lista_medicamientos.dart';
import 'package:flutter1/widgets/pantalla6_agenda_medicamientos.dart';

class pantalla7_borrar_medicamiento extends StatefulWidget {
  @override
  _MedicamentosScreenState createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<pantalla7_borrar_medicamiento> {
  BDHelper bdHelper = BDHelper();
  List<Map<String, dynamic>> medicamentosAReponer = [];
  int minhavariavel = nameState.id;
  int _selectedIndex = 0; // Índice seleccionado inicialmente

  @override
  void initState() {
    super.initState();
    _carregarMedicamentos();
  }

  Future<void> _carregarMedicamentos() async {
    List<Map<String, dynamic>> medicamentos =
        await bdHelper.consultarMedicamentos(minhavariavel);

    // Verifica se o widget está montado antes de chamar setState()
    if (mounted) {
      setState(() {
        medicamentosAReponer = medicamentos;
      });
    }
  }

  Future<void> _borrarMedicamento(int id) async {
    await bdHelper.borrarMedicamento(id);
    _carregarMedicamentos(); // Recarrega a lista após excluir o medicamento
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
              subtitle: Text(
                'Cantidad restante: ${medicamentosAReponer[index]['quantidade']}',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  _borrarMedicamento(medicamentosAReponer[index]['id']);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 152, 177, 233),
                ),
                child: Text('Borrar'),
              ),
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
        selectedItemColor: Colors.pink,
        unselectedItemColor: const Color.fromARGB(255, 228, 184, 198),
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          //adiciono la logica, que verifica qual item foi selecionado com base no índice e executa ações correspondentes
          if (_selectedIndex == 0) {
            Navigator.pushReplacement(
              //navegar para uma nova tela
              context,
              MaterialPageRoute(
                builder: (context) => Pantalla3_usuario(),
              ),
            );
          }
          if (_selectedIndex == 1) {
            Navigator.pushReplacement(
              //navegar para uma nova tela
              context,
              MaterialPageRoute(
                builder: (context) => Pantalla4_Anadir(),
              ),
            );
          }
          if (_selectedIndex == 2) {
            Navigator.pushReplacement(
              //navegar para uma nova tela
              context,
              MaterialPageRoute(
                builder: (context) => AgendaMedicamentos(),
              ),
            );
          }
          if (_selectedIndex == 3) {
            Navigator.pushReplacement(
              //navegar para uma nova tela
              context,
              MaterialPageRoute(
                builder: (context) => pantalla5_lista_medicamientos(),
              ),
            );
          }
        },
      ),
    );
  }
}
