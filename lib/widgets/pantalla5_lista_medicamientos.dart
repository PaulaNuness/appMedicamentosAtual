import 'package:flutter/material.dart';
import 'package:flutter1/BDHelper.dart';
import 'package:flutter1/widgets/pantalla3_usuario.dart';

class pantalla5_lista_medicamientos extends StatefulWidget {
  @override
  _MedicamentosScreenState createState() => _MedicamentosScreenState();
}

class _MedicamentosScreenState extends State<pantalla5_lista_medicamientos> {
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
                'Quantidade restante: ${medicamentosAReponer[index]['quantidade']}',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
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
            primary: Color.fromARGB(255, 233, 83, 208),
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
                    color:  Color.fromARGB(255, 233, 83, 208),
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
