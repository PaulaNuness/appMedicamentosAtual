

import 'package:flutter/material.dart';

/// Clase que carga el tema de la aplicación
/// Permite alternar entre tema claro y oscuro
/// Si en el constructor se le pasa un 0 carga el tema claro
/// Si en el constructor se le pasa un 1 carga el tema oscuro
/// Si en el constructor se le pasa cualquier otro valor carga el tema claro
class CargadorTema with ChangeNotifier {
  
  late ThemeData _tema; 

  bool _temaOscuro = false;
  bool _temaClaro = false;

  bool get temaOscuro => this._temaOscuro;
  ThemeData get temaActual => this._tema;
  
  CargadorTema(int tema) {
    //fijamos el tema activo
    switch (tema) {
      case 0:
        this._tema = _miTemaClaro();
        this._temaClaro = true;
        this._temaOscuro = false;
        break;
      case 1:
      //modificamos valores del tema oscuro para nuestra app
        this._tema = _miTemaOscuro();
        this._temaOscuro = true;
        this._temaClaro = false;
        break;
      default:
        this._tema =  _miTemaClaro();
        this._temaClaro = true;
        break;
    }
  }
  
  set temaOscuro(bool value) {
    this._temaOscuro = value;
    this._temaClaro = !value;
    //fijamos el tema activo
    if (value) {
      //modificamos valores del tema oscuro para nuestra app
      this._tema = _miTemaOscuro();
    } else {
      this._tema = _miTemaClaro();
    }
    notifyListeners();
  }

  set temaClaro(bool value) {
    this._temaClaro = value;
    this._temaOscuro = !value;
    //fijamos el tema activo
    if (value) {
      this._tema = _miTemaClaro();
    } else {
      this._tema = _miTemaOscuro();
    }
    notifyListeners();
  }

  ThemeData _miTemaClaro(){
    return (ThemeData.light().copyWith(
          colorScheme: const ColorScheme(
            primary: Color(0xFF2196F3), // Azul primario
            secondary: Color.fromARGB(255, 134, 208, 248), // Color secundario
            background: Color.fromARGB(255, 214, 236, 250), // Color de fondo
            surface: Colors.white, // Color de la superficie
            onPrimary: Colors.black, // Color del texto sobre el color primario
            onSecondary: Colors.black, // Color del texto sobre el color secundario
            onBackground: Colors.black, // Color del texto sobre el fondo
            onSurface: Colors.black, // Color del texto sobre la superficie
            brightness: Brightness.light, // Brillo del tema claro
            error: Color(0xFFFF6E40),
            onError: Color(0xFFECEFF1),
            tertiary: Colors.white,
            onTertiary:Colors.grey,
          ),
        )
      );
  }
  ThemeData _miTemaOscuro(){
    return (ThemeData.dark().copyWith(
        colorScheme: const ColorScheme(
           primary: Color(0xFF1976D2), // Azul primario para el tema oscuro
            secondary: Color.fromARGB(255, 45, 52, 151), // Color secundario para el tema oscuro
            background: Color(0xFF121212), // Color de fondo para el tema oscuro
            surface: Color(0xFF1E1E1E), // Color de la superficie para el tema oscuro
            onPrimary: Colors.white, // Color del texto sobre el color primario en el tema oscuro
            onSecondary: Colors.black, // Color del texto sobre el color secundario en el tema oscuro
            onBackground: Colors.white, // Color del texto sobre el fondo en el tema oscuro
            onSurface: Colors.white, // Color del texto sobre la superficie en el tema oscuro
            brightness: Brightness.dark,  // Brillo del tema oscuro 
            error: Color(0xFFFF5252), 
            onError: Color(0xFF212121),
            tertiary: Colors.black,
            onTertiary:Colors.grey,
            ),
      )
    );
  }

}