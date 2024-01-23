  import 'package:shared_preferences/shared_preferences.dart';

  class Configuracion{
    static final Configuracion _instancia = new Configuracion._internal();

    factory Configuracion() {
      return _instancia;
    }

    Configuracion._internal();

    Future<String?> getParametro(String parametro) async {
      String? valor;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        valor = prefs.getString(parametro);
      } catch (e) {
        print(e);
      }
      return valor;
    }

    Future<bool> setParametro(String parametro, String valor) async {
      bool ok = false;
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        ok = await prefs.setString(parametro, valor);
      } catch (e) {
        print(e);
      }
      return ok;
    }
  }
