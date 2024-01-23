  import 'package:flutter/material.dart';
  import 'package:flutter1/BDHelper.dart';
  import 'package:flutter1/widgets/pantalla3_usuario.dart';

  import 'package:flutter/material.dart';
  import 'package:flutter1/BDHelper.dart';
  import 'package:flutter1/widgets/pantalla3_usuario.dart';

  class Pantalla4_Anadir extends StatefulWidget {
    @override
    _Pantalla4AnadirState createState() => _Pantalla4AnadirState();
  }

  class _Pantalla4AnadirState extends State<Pantalla4_Anadir> {
    BDHelper bdHelper = BDHelper();

    String? selectedMedicamento;
    String? selectedNumero;
    String? selectedDias;
    String? selectedComprimidos;
    List<String> selectedHorarios = [];

    TextEditingController recomendacionesController = TextEditingController();

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
                    items: ['DÍAS', 'MESES', 'AÑOS']
                        .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        })
                        .toList(),
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
                      controller: recomendacionesController,
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
                          // Voltar para a tela de usuário
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Pantalla3_usuario(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary:Color.fromARGB(255, 233, 83, 208),
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
                          _guardarEnBaseDatos();
                        },
                        backgroundColor: Color.fromARGB(255, 233, 83, 208),
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

    void _guardarEnBaseDatos() {
      // Verifica se todos os campos necessários foram preenchidos
      List<String> emptyFields = checkEmptyFields();
      if (emptyFields.isNotEmpty) {
        // Exibe uma mensagem indicando campos inválidos
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Campos Inválidos"),
              content: Text("Por favor, preencha todos os campos corretamente.",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.pink,),),
                ),
              ],
            );
          },
        );
        return; // Sai da função se algum campo estiver vazio
      }

      // Cria um mapa com os dados do medicamento
      Map<String, dynamic> fila = {
        'nome': selectedMedicamento,
        'quantidade': int.parse(selectedNumero ?? '0'),
        'unidadeTempo': selectedDias,
        'quantidadeEnvase': int.parse(selectedComprimidos ?? '0'),
        'recomendacoes': recomendacionesController.text,
        'horarios': selectedHorarios.join(','),
      };

      // Insere o medicamento no banco de dados
      bdHelper.insertarBD('Medicamento', fila);

            showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Medicamento Inserido"),
              content: Text("Medicamento inserido com sucesso!"),
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
      // Limpar os campos após a inserção
      setState(() {
        selectedMedicamento = null;
        selectedNumero = null;
        selectedDias = null;
        selectedComprimidos = null;
        selectedHorarios = [];
        recomendacionesController.clear();
      });

      // Exibir uma mensagem indicando que os dados foram inseridos
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Medicamento inserido com sucesso!'),
          duration: Duration(seconds: 2),
        ),
      );
    }

    List<String> checkEmptyFields() {
      List<String> emptyFields = [];

      if (selectedMedicamento == null || selectedMedicamento!.isEmpty) {
        emptyFields.add("Medicamento");
      }
      if (selectedNumero == null) {
        emptyFields.add("Número");
      }
      if (selectedDias == null) {
        emptyFields.add("Unidade de Tempo");
      }
      if (selectedComprimidos == null) {
        emptyFields.add("Quantidade no Envase");
      }
      if (selectedHorarios.isEmpty) {
        emptyFields.add("Horários");
      }
      if (recomendacionesController.text.isEmpty) {
        emptyFields.add("Recomendações");
      }

      return emptyFields;
    }
  }
