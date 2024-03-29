import 'dart:async';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/models/visitamedica.dart';
import 'package:flutter1/modo/modo_trabajo.dart';
import 'package:flutter1/widgets/Registro_hecho.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';
import 'package:flutter1/widgets/pantalla4_anadir.dart';
import 'package:flutter1/widgets/pantalla5_lista_medicamientos.dart';
import 'package:flutter1/widgets/pantalla9_visitasmedicas.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AgendaMedicamentos extends StatefulWidget {
  @override
  _AgendaMedicamentosState createState() => _AgendaMedicamentosState();
}

class _AgendaMedicamentosState extends State<AgendaMedicamentos> {
  BDHelper bdHelper = BDHelper();
  List<Map<String, dynamic>> medicamentosAReponer = [];
  List<Map<String, dynamic>> proximasVisitas = [];
  List<VisitaMedica> proximasVisitas2 = []; // Alteração do tipo de lista
  int minhavariavel = nameState.id;

  @override
  void initState() {
    super.initState();
    _carregarMedicamentos();
    _carregarVisitas();
    _carregarVisitasFromAPI(); // Chama a função para carregar visitas da API
  }
    Future<void> _carregarVisitasFromAPI() async {
    try {
      List<VisitaMedica> visitas = await VisitaMedica.getFromAPI();
      setState(() {
        proximasVisitas2 = visitas;
      });
    } catch (e) {
      print('Erro ao carregar visitas médicas da API: $e');
    }
  }

  Future<void> _carregarMedicamentos() async {
    List<Map<String, dynamic>> medicamentos =
        await bdHelper.consultarMedicamentos(minhavariavel);

    setState(() {
      medicamentosAReponer = medicamentos;
    });
  }

  Future<void> _carregarVisitas() async {
    List<Map<String, dynamic>> visitas =
        await bdHelper.consultarVisitas(minhavariavel);

    setState(() {
      proximasVisitas = visitas;
    });
  }

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Pantalla1_Inicio(),
    Pantalla4_Anadir(),
    AgendaMedicamentos(),
    pantalla5_lista_medicamientos(),
  ];

  @override
  Widget build(BuildContext context) {
    final modoTrabajo = Provider.of<ModoTrabajo>(context);
    debugPrint('Conteúdo da variável modoTrabajo: ${modoTrabajo.modoRemoto}');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[300],
        title: Center(
          child: Text(
            'Medicamientos/Horario ',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: medicamentosAReponer.length,
              itemBuilder: (context, index) {
                var medicamento = medicamentosAReponer[index];

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      medicamento['nome'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Horarios: ${medicamento['horarios']}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await bdHelper.decrementarQuantidadeMedicamento(
                                medicamento['id'] as int);
                            await _carregarMedicamentos();

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("OKEY"),
                                  content: Text("Felicidades, pronto estarás mejor"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.pink,)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 152, 177, 233),
                          ),
                          child: Text('SI'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Por favor"),
                                  content: Text("Debes tomar la medicacion"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.pink,)),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                          ),
                          child: Text('NO'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaginaVisitaMedica(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(30.0),
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                primary: Color.fromARGB(255, 233, 83, 208),
              ),
              child: Text('MARCAR CONSULTAS(Visitas Medicas)'),
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Próximas Visitas ao Médico:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: !modoTrabajo.modoRemoto, //si es local
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink),
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Especialidad')),
                          DataColumn(label: Text('Nombre Médico')),
                          DataColumn(label: Text('Fecha')),
                        ],
                        rows: proximasVisitas.map((visita) {
                          return DataRow(cells: [
                            DataCell(
                              Text(
                                visita['especialidad'],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                visita['doctor'],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                visita['fecha'],
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                ),
    Visibility(
      visible: modoTrabajo.modoRemoto,
      child: Container(
        height: 150,
        child: ListView.builder(
          itemCount: proximasVisitas2.length, // Usando o tamanho da lista de visitas
          itemBuilder: (context, index) {
            final visita = proximasVisitas2[index]; // Obtendo a visita atual da lista
            return Card(
              elevation: 5,
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DR. ${visita.doctor}', // Usando o nome do médico da visita
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Especialidad: ${visita.especialidad}', // Usando a especialidade da visita
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
              ],
            ),
          ),
          SizedBox(height: 50),
        ],
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

  Future<void> _decrementarQuantidadeMedicamento(int index) async {
    if (index >= 0 && index < medicamentosAReponer.length) {
      int idMedicamento = medicamentosAReponer[index]['id'];

      await bdHelper.decrementarQuantidadeMedicamento(idMedicamento);

      _carregarMedicamentos();
    }
  }
}


