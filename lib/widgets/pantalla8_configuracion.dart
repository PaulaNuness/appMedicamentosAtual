import 'package:flutter/material.dart';
import 'package:flutter1/modo/modo_trabajo.dart';
import 'package:flutter1/tema/tema.dart';
import 'package:provider/provider.dart';

class PantallaConfiguracion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final temaActual = Provider.of<CargadorTema>(context);
    final modoTrabajo = Provider.of<ModoTrabajo>(context);

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionHeader("Ajustes generales", temaActual),
          buildDivider(temaActual),
          buildSectionHeader("Ajustes de apariencia", temaActual),
          buildSwitchListTile(
            "Tema oscuro",
            temaActual.temaOscuro,
            (value) => temaActual.temaOscuro = value,
            temaActual,
          ),
          buildDivider(temaActual),
          buildSectionHeader("Ajustes de usuario", temaActual),
          buildSwitchListTile(
            "Funcionamiento local",
            modoTrabajo.modoLocal,
            (value) => modoTrabajo.modoLocal = value,
            temaActual,
          ),
        ],
      ),
    );
  }

  Widget buildSectionHeader(String title, CargadorTema temaActual) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          color: temaActual.temaActual.colorScheme.onSecondary,
        ),
      ),
      tileColor: temaActual.temaActual.colorScheme.secondary,
    );
  }

  Widget buildDivider(CargadorTema temaActual) {
    return Divider(
      color: temaActual.temaActual.colorScheme.primary,
    );
  }

  Widget buildSwitchListTile(
    String title,
    bool value,
    Function(bool) onChanged,
    CargadorTema temaActual,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: 25,
          color: temaActual.temaActual.colorScheme.onPrimary,
        ),
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
