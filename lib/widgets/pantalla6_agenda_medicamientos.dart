import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';
import 'package:flutter1/widgets/pantalla4_anadir.dart';
import 'package:flutter1/widgets/pantalla5_lista_medicamientos.dart';
import 'package:intl/intl.dart';



class VisitaMedico {
  String nomeMedico;
  DateTime dataVisita;

  VisitaMedico({required this.nomeMedico, required this.dataVisita});
}

class AgendaMedicamentos extends StatefulWidget {
  @override
  _AgendaMedicamentosState createState() => _AgendaMedicamentosState();
}

class _AgendaMedicamentosState extends State<AgendaMedicamentos> {
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
  int _selectedIndex = 0;
  late Timer _timer;

  final List<Widget> _pages = [
    Pantalla1_Inicio(),
    Pantalla4_Anadir(),
    AgendaMedicamentos(),
    pantalla5_lista_medicamientos(),
  ];

  List<VisitaMedico> visitasMedicas = [
    VisitaMedico(nomeMedico: 'Dr. Silva', dataVisita: DateTime.now().add(Duration(days: 7))),
    VisitaMedico(nomeMedico: 'Dra. Santos', dataVisita: DateTime.now().add(Duration(days: 14))),
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
        automaticallyImplyLeading: false, // Impede a exibição do botão de voltar
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
            child: Expanded(
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
                onPressed: () {
                  // Lógica para o primeiro botão
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 152, 177, 233),
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


          ),
          SizedBox(height: 50),
          Text(
            'Próximas Visitas ao Médico:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.pink),
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
          SizedBox(height: 50),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10.0),
        child: ElevatedButton(
                    onPressed: () {
                                    // Voltar para a tela de usuário
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pantalla3_usuario(),
                          ),
                        );
          },
          style: ElevatedButton.styleFrom(
            primary:Color.fromARGB(255, 152, 177, 233),
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
}
