import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter1/modo/modo_trabajo.dart';
import 'package:flutter1/tema/tema.dart';
import 'package:flutter1/tipo_usuario/tipo_usuario.dart';
import 'package:provider/provider.dart';

class Pantalla8_configuracion extends StatefulWidget {
  Pantalla8_configuracion({Key? key});

  @override
  State<Pantalla8_configuracion> createState() => PaginaConfiguracionState();
}

class PaginaConfiguracionState extends State<Pantalla8_configuracion> {
  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context);
    final modoTrabajo = Provider.of<ModoTrabajo>(context);
    final tipousuario = Provider.of<TipoUsuario>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajustes',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: temaActual.temaActual.colorScheme.onPrimary,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: temaActual.temaActual.colorScheme.primary,
          ),
        ),
        iconTheme: IconThemeData(
          color: temaActual.temaActual.colorScheme.onPrimary,
        ),
      ),
      body: Center(
        child: Container(
          width: 350,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              // Sección 1 Ajustes generales
              Container(
              decoration: BoxDecoration(
  border: Border.all(
    color: Color.fromARGB(255, 62, 8, 161),
    width: 3, // Largura da borda
  ),
  borderRadius: BorderRadius.circular(10),
),

                child: ListTile(
                  title: Text(
                    "Ajustes generales",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: temaActual.temaActual.colorScheme.onSecondary,
                    ),
                  ),
                  tileColor: temaActual.temaActual.colorScheme.secondary,
                ),
              ),
              SizedBox(height: 10), // Espaçamento
              // Sección 2 Ajustes de Apariencia
              Container(
               decoration: BoxDecoration(
  border: Border.all(
    color: Color.fromARGB(255, 62, 8, 161),
    width: 3, // Largura da borda
  ),
  borderRadius: BorderRadius.circular(10),
),

                child: Column(
                  children: [
                    Divider(
                      color: temaActual.temaActual.colorScheme.primary,
                    ),
                    ListTile(
                      title: Text(
                        "Ajustes de apariencia",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: temaActual.temaActual.colorScheme.onSecondary,
                        ),
                      ),
                      tileColor: temaActual.temaActual.colorScheme.secondary,
                    ),
                    SwitchListTile(
                      title: Text(
                        "Tema oscuro",
                        style: TextStyle(
                          fontSize: 25,
                          color: temaActual.temaActual.colorScheme.onPrimary,
                        ),
                      ),
                      value: temaActual.temaOscuro,
                      onChanged: (value) => temaActual.temaOscuro = value,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10), // Espaçamento
              // Sección 3 Ajustes del tipo de usuario
              Container(
                decoration: BoxDecoration(
  border: Border.all(
    color: Color.fromARGB(255, 62, 8, 161),
    width: 3, // Largura da borda
  ),
  borderRadius: BorderRadius.circular(10),
),

                child: Column(
                  children: [
                    Divider(
                      color: temaActual.temaActual.colorScheme.primary,
                    ),
                    ListTile(
                      title: Text(
                        "Ajustes de usuario",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: temaActual.temaActual.colorScheme.onSecondary,
                        ),
                      ),
                      tileColor: temaActual.temaActual.colorScheme.secondary,
                    ),
                    SwitchListTile(
                      title: Text(
                        "Funcionamiento local",
                        style: TextStyle(
                          fontSize: 25,
                          color: temaActual.temaActual.colorScheme.onPrimary,
                        ),
                      ),
                      value: modoTrabajo.modoLocal,
            onChanged: (value) => modoTrabajo.modoLocal = value,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
