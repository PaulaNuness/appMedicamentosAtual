import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/widgets/Registro_hecho.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';
import 'package:flutter1/widgets/pantalla4_anadir.dart';
import 'package:flutter1/widgets/pantalla5_lista_medicamientos.dart';
import 'package:flutter1/widgets/pantalla9_visitasmedicas.dart';
import 'package:intl/intl.dart';

class AgendaMedicamentos extends StatefulWidget {
  @override
  _AgendaMedicamentosState createState() => _AgendaMedicamentosState();
}

class _AgendaMedicamentosState extends State<AgendaMedicamentos> {
  BDHelper bdHelper = BDHelper();
  List<Map<String, dynamic>> medicamentosAReponer = [];
  List<Map<String, dynamic>> proximasVisitas = [];
  int minhavariavel = Pantalla1_Inicio.id;

  @override
  void initState() {
    super.initState();
    _carregarMedicamentos();
    _carregarVisitas();
  }

  Future<void> _carregarMedicamentos() async {
    List<Map<String, dynamic>> medicamentos = await bdHelper.consultarMedicamentos(minhavariavel);

    setState(() {
      medicamentosAReponer = medicamentos;
    });
  }

  Future<void> _carregarVisitas() async {
    List<Map<String, dynamic>> visitas = await bdHelper.consultarVisitas();

    setState(() {
      proximasVisitas = visitas;
    });
  }

  int _selectedIndex = 0;
  late Timer _timer;

  final List<Widget> _pages = [
    Pantalla1_Inicio(),
    Pantalla4_Anadir(),
    AgendaMedicamentos(),
    pantalla5_lista_medicamientos(),
  ];

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            // Chame o método para decrementar a quantidade
                            await bdHelper.decrementarQuantidadeMedicamento(medicamento['id'] as int);
                            // Atualize a lista de medicamentos
                            await _carregarMedicamentos();

                            // Mostrar o AlertDialog
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
                                      child: Text("OK",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.pink,)),
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
                                      child: Text("OK",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.pink,)),
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
          Text(
            'Próximas Visitas ao Médico:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0), // Ajuste o valor conforme necessário
            child: Container(
              alignment: Alignment.center,
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
          SizedBox(height: 50),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Pantalla3_usuario(),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Color.fromARGB(255, 152, 177, 233),
            padding: EdgeInsets.symmetric(vertical: 15.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            'Sair',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
