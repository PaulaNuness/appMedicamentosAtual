import 'package:flutter/material.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';

class Pantalla4_Anadir extends StatefulWidget {
  @override
  _Pantalla4AnadirState createState() => _Pantalla4AnadirState();
}

class _Pantalla4AnadirState extends State<Pantalla4_Anadir> {
  String? selectedMedicamento;//la variable va tener un String o un vacio
  String? selectedNumero;
  String? selectedDias;
  String? selectedComprimidos;
  List<String> selectedHorarios = [];//Inicializando una variable de String vacia

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // estructura de la interfaz
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
          child: SingleChildScrollView(// no me salir la barra amarilla y negro
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                DropdownButton<String>(//Cria um widget de botão suspenso onde os valores selecionados são do tipo String
                  isExpanded: true,//Essa propriedade faz com que o dropdown ocupe toda a largura disponível, expandindo-se horizontalmente
                  value: selectedMedicamento,//valor inicial
                  items: <String>['PARACETAMOL', 'IBUPROFENO', 'AMOXICILINA', 'PARACETAMOL', 'OMEPRAZOL', 'ASPIRINA C', 'NOLOTIL', 'DIAZEPAM']//lista de opciones en el DropdownButton. Cada opcion es encapsulada en un DropdownMenuItem
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),//Converte a lista de strings em uma lista de widgets DropdownMenuItem<String>. Cada item na lista é um widget que representa uma opção no dropdown
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedMedicamento = newValue;
                    });
                  },//Especifica uma função que será chamada quando o valor selecionado no dropdown for alterado. O novo valor selecionado é passado como parâmetro (newValue),Atualiza o estado da classe StatefulWidget com o novo valor selecionado, garantindo que a interface do usuário seja reconstruída para refletir a alteração
                  hint: Text('SELECCIONAR MEDICAMENTO'),
                ),


                SizedBox(height: 20),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedNumero,//valor inicial
                  items: List.generate(31, (index) => (index + 1).toString())//cria una lista de 1 a 31
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {//el metodo el llamado
                      selectedNumero = newValue;//la variable selectedNumero que armazena el valor atualmente selecionado
                    });
                  },
                  hint: Text('SELECCIONAR CANTIDAD'),
                ),


                SizedBox(height: 10),
                DropdownButton<String>(// botão suspenso,os valores selecionados serão do tipo String
                  isExpanded: true,// dropdown ocupe toda a largura disponível, expandindo-se horizontalmente
                  value: selectedDias,//valor inicial
                  items: ['DÍAS', 'MESES', 'AÑOS']// lista de itens disponíveis no dropdown
                      .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),//Converte a lista de strings em uma lista de widgets DropdownMenuItem<String>
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDias = newValue;//la variable selectedNumero que armazena el valor atualmente selecionado
                    });
                  },//Especifica uma função que será chamada quando o valor selecionado no dropdown for alterado. O novo valor selecionado é passado como parâmetro (newValue)
                  hint: Text('SELECCIONAR UNIDAD DE TIEMPO'),
                ),


                SizedBox(height: 20),
                DropdownButton<String>(
                  isExpanded: true,
                  value: selectedComprimidos,
                  items: List.generate(30, (index) => (index + 1).toString())//Gera uma lista de 30 strings, onde cada string é o resultado da expressão (index + 1).toString(). Isso cria uma lista de números de 1 a 30
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
                  child: TextField(),
                ),
                SizedBox(height: 20),
                Text(
                  'Horario/Alertas:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),


                Container(
                  height: 130,
                  child: GridView.builder(//Cria um widget de grade (grid) onde os itens são construídos dinamicamente por meio de um construtor de itens
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(//Define a estrutura da grade, especificando o número fixo de colunas e espaçamentos entre as colunas e linhas
                      crossAxisCount: 4,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 5.0,
                    ),
                    itemCount: 24,//Especifica o número total de itens na grade, que neste caso é 24
                    itemBuilder: (context, index) {// Uma função que é chamada para construir cada item da grade. O índice index é usado para determinar qual item está sendo construído
                      String horario =
                          '${index.toString().padLeft(2, '0')}:00';// Cria uma string representando um horário formatado a partir do índice. Por exemplo, para o índice 0, a string será "00:00"
                      return GestureDetector(//dentro do itemBuilder cria um GestureDetector para cada item da grade. Esse detector de gestos responde a toques, alternando a seleção do horário quando um item é tocado
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
                                      builder: (context) =>
                                          Pantalla3_usuario(),
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
}