import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';

class pantalla7_borrar_medicamiento extends StatefulWidget {
  @override
  _MedicamentosScreenState createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<pantalla7_borrar_medicamiento> {
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
              trailing: ElevatedButton(
                onPressed: () {
                  _borrarMedicamento(medicamentosAReponer[index]['id']); // Chama a função para excluir o medicamento
                },
                child: Text('Borrar'),
              ),
            );
          },
        ),
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
}
