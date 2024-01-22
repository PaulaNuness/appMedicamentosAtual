import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter1/modo/modo_trabajo.dart';
import 'package:flutter1/tema/tema.dart';
import 'package:provider/provider.dart';

class Pantalla8_configuracion extends StatefulWidget {
  Pantalla8_configuracion({super.key});

  @override
  State<Pantalla8_configuracion> createState() => PaginaConfiguracionState();
}

class PaginaConfiguracionState extends State<Pantalla8_configuracion> {
  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context);
    final modoTrabajo = Provider.of<ModoTrabajo>(context);

    setState(() {});
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: temaActual.temaActual.colorScheme.onPrimary,
            )),
        //configuramos el color de fondo
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: temaActual.temaActual.colorScheme.primary,
          ),
        ),
        //configuramos el color de los iconos
        iconTheme: IconThemeData(
          color: temaActual.temaActual.colorScheme.onPrimary,
        ),
      ),
      body: Center(
        child: ListView(children: [
          //Sección 1 Ajustes generales
          ListTile(
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
          //Sección 2 Ajustes de Apariencia
          //separador
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
          //Sección 3 Ajustes del tipo de usuario
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
                color: temaActual.temaActual.colorScheme.onPrimary,
              ),
            ),
            value: modoTrabajo.modoLocal,
            onChanged: (value) => modoTrabajo.modoLocal = value,
          ),
        ]),
      ),
    );
  }
}
