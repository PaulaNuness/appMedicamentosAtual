import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';
import 'package:flutter1/widgets/pantalla4_anadir.dart';
import 'package:flutter1/widgets/pantalla5_lista_medicamientos.dart';
import 'package:intl/intl.dart';

class Medicamento {
  String nombre;
  DateTime horaProxima;

  Medicamento({required this.nombre, required this.horaProxima});
}

class AgendaMedicamentos extends StatefulWidget {
  @override
  _AgendaMedicamentosState createState() => _AgendaMedicamentosState();
}

class VisitaMedico {
  String nomeMedico;
  DateTime dataVisita;

  VisitaMedico({required this.nomeMedico, required this.dataVisita});
}

class _AgendaMedicamentosState extends State<AgendaMedicamentos> {
  int _selectedIndex = 0;
  late Timer _timer;

  // Lista de páginas correspondentes a cada índice do BottomNavigationBar
  final List<Widget> _pages = [
    Pantalla1_Inicio(),
    Pantalla4_Anadir(),
    AgendaMedicamentos(),
    pantalla5_lista_medicamientos(),
  ];

  List<VisitaMedico> visitasMedicas = [
    VisitaMedico(nomeMedico: 'Dr. Silva', dataVisita: DateTime.now().add(Duration(days: 7))),
    VisitaMedico(nomeMedico: 'Dra. Santos', dataVisita: DateTime.now().add(Duration(days: 14))),
    // Adicione mais visitas conforme necessário
  ];

  List<Medicamento> medicamentos = [
    Medicamento(nombre: 'Paracetamol', horaProxima: DateTime.now().add(Duration(hours: 2)),),
    Medicamento(nombre: 'Ibuprofeno', horaProxima: DateTime.now().add(Duration(hours: 14))),
    Medicamento(nombre: 'Amoxicilina', horaProxima: DateTime.now().add(Duration(hours: 6))),
    Medicamento(nombre: 'Diclofenaco', horaProxima: DateTime.now().add(Duration(hours: 12))),
    Medicamento(nombre: 'Diazepam', horaProxima: DateTime.now().add(Duration(hours: 4))),
    Medicamento(nombre: 'Omeprazol', horaProxima: DateTime.now().add(Duration(hours: 16))),
    Medicamento(nombre: 'Aspirina C', horaProxima: DateTime.now().add(Duration(hours: 2))),
    Medicamento(nombre: 'Nolotil', horaProxima: DateTime.now().add(Duration(hours: 4))),
    Medicamento(nombre: 'Acomicil', horaProxima: DateTime.now().add(Duration(hours: 6))),
    Medicamento(nombre: 'Orfidal', horaProxima: DateTime.now().add(Duration(hours: 6))),
  ];

  @override
  void initState() {
    super.initState();
    // Ordenar a lista de medicamentos pelos horários
    medicamentos.sort((a, b) => a.horaProxima.compareTo(b.horaProxima));
    // Iniciar a atualização do tempo restante
    _timer = Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        // Actualizar el tiempo restante cada minuto
        for (var medicamento in medicamentos) {
          medicamento.horaProxima = medicamento.horaProxima.subtract(Duration(minutes: 1));
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancelar o timer no dispose para evitar setState após descarte
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300], // Cor de fundo cinza
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
          // Lista de medicamentos
          Expanded(
            child: ListView.builder(
              itemCount: medicamentos.length,
              itemBuilder: (context, index) {
                var medicamento = medicamentos[index];
                var tiempoRestante = medicamento.horaProxima.difference(DateTime.now());

                return Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      medicamento.nombre,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 5),
                        Text(
                          'Próxima dose em: ${tiempoRestante.inHours}h ${tiempoRestante.inMinutes.remainder(60)}min',
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.pink, size: 18),
                            SizedBox(width: 5),
                            Text(
                              'Às ${DateFormat.Hm().format(medicamento.horaProxima)}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para o primeiro botão
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.pink,
                          ),
                          child: Text('SI'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            // Lógica para o segundo botão
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
          SizedBox(height: 50), // Espaçamento entre as listas
          // Tabela de visitas ao médico
          Text(
            'Próximas Visitas ao Médico:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            alignment: Alignment.center, // Centralizar a tabela
            decoration: BoxDecoration(
              border: Border.all(color: Colors.pink), // Adicionar borda
              borderRadius: BorderRadius.all(Radius.circular(30.0)), // Opcional: Adicionar bordas arredondadas
            ),
            child: DataTable(
              columns: [
                DataColumn(label: Text('Médico')),
                DataColumn(label: Text('Data')),
              ],
              rows: visitasMedicas.map((visita) {
                return DataRow(cells: [
                  DataCell(Text(visita.nomeMedico)),
                  DataCell(Text(DateFormat('dd/MM/yyyy').format(visita.dataVisita))),
                ]);
              }).toList(),
            ),
          ),
          SizedBox(height: 50)
        ],
      ),
    );
  }
}
