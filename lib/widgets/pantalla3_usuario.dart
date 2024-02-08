  import 'package:flutter/material.dart';
import 'package:flutter1/modo/modo_trabajo.dart';
  import 'package:flutter1/widgets/pantalla1_inicio.dart';
  import 'package:flutter1/widgets/pantalla4_anadir.dart';
  import 'package:flutter1/widgets/pantalla5_lista_medicamientos.dart';
  import 'package:flutter1/widgets/pantalla6_agenda_medicamientos.dart';
  import 'package:flutter1/widgets/pantalla7_borrar_medicamento.dart';
import 'package:flutter1/widgets/pantalla8_configuracion.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


  class Pantalla3_usuario extends StatefulWidget {
    
    
    @override
    _Pantalla3_usuarioState createState() => _Pantalla3_usuarioState();
  }

  class _Pantalla3_usuarioState extends State<Pantalla3_usuario> {
    int _selectedIndex = 0;
    //String minhavariavel2 =Pantalla1_Inicio.nombre.toUpperCase();
    
    // Lista de páginas correspondentes a cada índice do BottomNavigationBar
    final List<Widget> _pages = [
      Pantalla1_Inicio(),
      Pantalla4_Anadir(),
      AgendaMedicamentos(),
      pantalla7_borrar_medicamiento(),
      pantalla5_lista_medicamientos(),
    ];

    // Função chamada quando uma aba é pressionada
    void _onItemTapped(int index) {
      setState(() {
      
        _selectedIndex = index;
      
      });
    }

    @override
    Widget build(BuildContext context) {
      final modoTrabajo = Provider.of<ModoTrabajo>(context);
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          //configuración de la barra superior de la aplicación
          appBar: AppBar(
            backgroundColor: Colors.grey[300],
            title: Center(
              child: Text(
                'Hola, ',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontFamily: 'Arial',
                ),
              ),
            ),
                    actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Pantalla8_configuracion(),
                ),
              );
            },
          ),
        ],
          ),

          //Drawer (menú lateral derecha, denrto de la barra superior)
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 233, 83, 208),
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color:  Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),

                //definición de un elemento de lista (ListTile) en el menú lateral (Drawer)
                ListTile(
                  title: Text('ANADIR'),
                  onTap: () {
                    // Navegar para a tela Pantalla4_Anadir
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pantalla4_Anadir(),
                      ),
                    );
                  },
                ),

                //definición de un elemento de lista (ListTile) en el menú lateral (Drawer)
                ListTile(
                  title: Text('AGENDA'),
                  
                  onTap: () {
                    // Navegar para a tela Agenda de medicamientos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AgendaMedicamentos(),
                      ),
                    );
                  },
                ),

                //definición de un elemento de lista (ListTile) en el menú lateral (Drawer)
                ListTile(
                  title: Text('BORRAR'),
                  onTap: () {
                    
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pantalla7_borrar_medicamiento(),
                      ),
                    );
                  },
                ),

                //definición de un elemento de lista (ListTile) en el menú lateral (Drawer)
                ListTile(
                  title: Text('LISTA'),
                  onTap: () {
                    // Navegar para a tela pantalla5_lista_medicamientos
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pantalla5_lista_medicamientos(),
                      ),
                    );
                  },
                ),
                //Puedo adicionar mais opções conforme necessário
              ],
            ),
          ),

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
            child: SingleChildScrollView(//para no me salir la barra amarilla y negro
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Que deseas hacer ',
                    style: TextStyle(fontSize: 28),
                  ),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width:
                          320, // Ajustei a largura para cobrir os cantos arredondados
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(20.0), // Borda arredondada
                        child: Container(
                          color: Color.fromARGB(255, 248, 228, 235),
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 33, 33, 214),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 12.0,
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navegar para a tela Pantalla4_Anadir
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Pantalla4_Anadir(),
                                      ),
                                    );
                                  },
                                style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 233, 83, 208),
                      padding: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Ajuste o valor conforme necessário
                      ),
                      elevation: 6.0,
                      shadowColor: Color.fromARGB(255, 33, 33, 214),
                    ),
                                  child: Text(
                                    'Añadir Medicamientos',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 227, 227, 235),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Sans-serif',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 33, 33, 214),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 12.0,
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navegar para a tela AgendaMedicamentos
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AgendaMedicamentos(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 233, 83, 208),
                      padding: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Ajuste o valor conforme necessário
                      ),
                      elevation: 6.0,
                      shadowColor: Color.fromARGB(255, 33, 33, 214),
                    ),
                                  child: Text(
                                    'Agenda Medicamientos',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 227, 227, 235),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Sans-serif',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 33, 33, 214),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 12.0,
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                    onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                          pantalla7_borrar_medicamiento(),
                                      ),
                                    );
                                  },
                                style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 233, 83, 208),
                      padding: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Ajuste o valor conforme necessário
                      ),
                      elevation: 6.0,
                      shadowColor: Color.fromARGB(255, 33, 33, 214),
                    ),
                                  child: Text(
                                    'Borrar Medicamientos',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 227, 227, 235),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Sans-serif',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 33, 33, 214),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 12.0,
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navegar para a tela pantalla5_lista_medicamientos
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            pantalla5_lista_medicamientos(),
                                      ),
                                    );
                                  },
                                style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 233, 83, 208),
                      padding: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Ajuste o valor conforme necessário
                      ),
                      elevation: 6.0,
                      shadowColor: Color.fromARGB(255, 33, 33, 214),
                    ),
                                  child: Text(
                                    'Lista Medicamientos',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 227, 227, 235),
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Sans-serif',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 33, 33, 214),
                          offset: Offset(0.0, 8.0),
                          blurRadius: 12.0,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                                    // Navegar para a tela pantalla5_lista_medicamientos
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Pantalla1_Inicio(),
                                      ),
                                    );
                                  },
                      style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 152, 177, 233),
                      padding: EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0), // Ajuste o valor conforme necessário
                      ),
                      elevation: 6.0,
                      shadowColor: Color.fromARGB(255, 33, 33, 214),
                    ),
                      child: Text(
                        'Salir',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Sans-serif',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),

          //la barra abajo que navegamos, por las pantallas
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                //el icono de home
                icon: Icon(Icons.home),
                label: 'Inicio',
                
              ),
              BottomNavigationBarItem(
                //el icono de +
                icon: Icon(Icons.add),
                label: 'Añadir',
              ),
              BottomNavigationBarItem(
                //el icono de un calendario
                icon: Icon(Icons.calendar_today),
                label: 'Agenda',
              ),
              BottomNavigationBarItem(
                //el icono de icono burguer
                icon: Icon(Icons.list),
                label: 'Lista',
              ),
            ],

            currentIndex: _selectedIndex,//widget de navegação que tem um índice de item atualmente selecionado. O valor desse índice está armazenado na variável _selectedIndex
            onTap: (index){// O índice do item tocado é passado como o parâmetro index
              setState(() {// Atualiza o estado da classe StatefulWidget com o novo índice selecionado
                _selectedIndex=index;
              });
              //adiciono la logica, que verifica qual item foi selecionado com base no índice e executa ações correspondentes
              if(_selectedIndex==0){
                Navigator.pushReplacement(//navegar para uma nova tela
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pantalla3_usuario(),
                  ),
              );
              }
              if(_selectedIndex==1){
                Navigator.pushReplacement(//navegar para uma nova tela
                  context,
                  MaterialPageRoute(
                    builder: (context) => Pantalla4_Anadir(),
                  ),
              );
              }
              if(_selectedIndex==2){
                Navigator.pushReplacement(//navegar para uma nova tela
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgendaMedicamentos(),
                  ),
              );
              }
              if(_selectedIndex==3){
                Navigator.pushReplacement(//navegar para uma nova tela
                  context,
                  MaterialPageRoute(
                    builder: (context) => pantalla5_lista_medicamientos(),
                  ),
              );
              }
            },
            selectedItemColor: Colors.pink,//color del texto,
            unselectedItemColor: const Color.fromARGB(255, 228, 184, 198),//color del texto,
          ),
        ),
      );
    }
  }
