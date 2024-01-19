import 'package:flutter/material.dart';


class pantalla5_lista_medicamientos extends StatefulWidget {
  @override
  _MedicamentosScreenState createState() => _MedicamentosScreenState();
}


class _MedicamentosScreenState extends State<pantalla5_lista_medicamientos> {
  List<String> medicamentosAReponer = [
    'PARACETAMOL',
    'IBUPROFENO',
    'AMOXICILINA',
    'OMEPRAZOL',
    'ASPIRINA C',
    'NOLOTIL',
    'DICLOFENACO',
    'ENALAPRIL',
    'AZITROMICINA',
    'METAMIZOL'
  ];
  List<int> quantidadesDisponiveis = [10, 5, 8, 5, 2,1, 5, 8, 13, 20];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Center(
          child: Text(
            'MEDICAMENTOS A REPOR',
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
            color: Colors.pink,
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
                backgroundColor: Colors.pink,
                child: Text(
                  '${quantidadesDisponiveis[index]}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                medicamentosAReponer[index],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Quantidade restante: ${quantidadesDisponiveis[index]}',
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
     endDrawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Center(
                child: Text(
                  'Menu Lateral',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text('Opção 1'),
              onTap: () {
                // Lógica quando a opção 1 é selecionada
                Navigator.pop(context); // Fechar o endDrawer
              },
            ),
            ListTile(
              title: Text('Opção 2'),
              onTap: () {
                // Lógica quando a opção 2 é selecionada
                Navigator.pop(context); // Fechar o endDrawer
              },
            ),
            ListTile(
              title: Text('Opção 2'),
              onTap: () {
                // Lógica quando a opção 2 é selecionada
                Navigator.pop(context); // Fechar o endDrawer
              },
            )
            // Adicione mais ListTile conforme necessário
          ],
        ),
      ),
    );
  }
}


class FarmaciasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> farmacias = [//lista con la ubicacion de las farmacia
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
            color: Colors.pink,
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
                    Icons.location_on, // Ícone de localização (você pode escolher outro ícone)
                    color: Colors.pink,
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
