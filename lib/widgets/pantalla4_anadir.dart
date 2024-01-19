import 'package:flutter/material.dart';
import 'package:flutter1/models/medicamentos.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';
import 'package:flutter1/BDHelper.dart';

class Pantalla4_Anadir extends StatefulWidget {
  @override
  _Pantalla4AnadirState createState() => _Pantalla4AnadirState();
}

class _Pantalla4AnadirState extends State<Pantalla4_Anadir> {
  String? selectedMedicamento;
  String? selectedNumero;
  String? selectedDias;
  String? selectedComprimidos;
  List<String> selectedHorarios = [];
  TextEditingController recomendacoesController = TextEditingController();
  BDHelper bdHelper = BDHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedMedicamento,
                  items: <String>[
                    'PARACETAMOL',
                    'IBUPROFENO',
                    'AMOXICILINA',
                    'PARACETAMOL',
                    'OMEPRAZOL',
                    'ASPIRINA C',
                    'NOLOTIL',
                    'DIAZEPAM'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMedicamento = newValue;
                    });
                  },
                  hint: Text('SELECCIONAR MEDICAMENTO'),
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedNumero,
                  items: List.generate(31, (index) => (index + 1).toString())
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedNumero = newValue;
                    });
                  },
                  hint: Text('SELECCIONAR CANTIDAD'),
                ),
                SizedBox(height: 10),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedDias,
                  items: ['DÍAS', 'MESES', 'AÑOS'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDias = newValue;
                    });
                  },
                  hint: Text('SELECCIONAR UNIDAD DE TIEMPO'),
                ),
                SizedBox(height: 20),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedComprimidos,
                  items: List.generate(30, (index) => (index + 1).toString())
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedComprimidos = newValue;
                    });
                  },
                  hint: Text('CANTIDAD EN EL ENVASE'),
                ),
                SizedBox(height: 20),
                Text(
                  'RECOMENDACIONES:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    controller: recomendacoesController,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Horario/Alertas:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  height: 130,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: 24,
                    itemBuilder: (context, index) {
                      String horario =
                          '${index.toString().padLeft(2, '0')}:00';
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedHorarios.contains(horario)) {
                              selectedHorarios.remove(horario);
                            } else {
                              selectedHorarios.add(horario);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(9.0),
                          decoration: BoxDecoration(
                            color: selectedHorarios.contains(horario)
                                ? Colors.blue
                                : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Text(
                            horario,
                            style: TextStyle(
                              fontSize: 18,
                              color: selectedHorarios.contains(horario)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Pantalla3_usuario(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.pink,
                        padding: EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        _adicionarMedicamento();
                      },
                      backgroundColor: Colors.pink,
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _adicionarMedicamento() async {
    String nome = selectedMedicamento ?? "";
    int quantidade = int.tryParse(selectedNumero ?? "0") ?? 0;
    String unidadeTempo = selectedDias ?? "";
    int quantidadeEnvase = int.tryParse(selectedComprimidos ?? "0") ?? 0;
    String recomendacoes = recomendacoesController.text;

    Medicamento medicamento = Medicamento.withoutId(
      nome,
      quantidade,
      unidadeTempo,
      quantidadeEnvase,
      recomendacoes,
      selectedHorarios,
    );

    Map<String, dynamic> medicamentoMap = medicamento.toMap();

    await bdHelper.insertarBD('Medicamento', medicamentoMap);
  }
}
