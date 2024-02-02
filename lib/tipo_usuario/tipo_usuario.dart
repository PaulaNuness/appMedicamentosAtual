import 'package:flutter/material.dart';
import 'package:flutter1/models/configuracion.dart';

class TipoUsuario with ChangeNotifier {
  bool _isAdmin = false;
  bool _isUser = false;

  bool get isAdmin => this._isAdmin;
  bool get isUser => this._isUser;
  
  TipoUsuario() {
    bool isAdmin=false;
    _checkTipoUsuario().then((value) => isAdmin=value);
    if (isAdmin) {
      this._isAdmin = true;
      this._isUser = false;
    } else {
      this._isAdmin = false;
      this._isUser = true;
    }
  }
  
  set isAdmin(bool value) {
    this._isAdmin = value;
    this._isUser = !value;
    if (value) {
      Configuracion().setParametro('tipoUsuario', 'admin');
    } else {
      Configuracion().setParametro('tipoUsuario', 'user');
    }
    notifyListeners();
  }

  set isUser(bool value) {
    this._isUser = value;
    this._isAdmin = !value;
    if (value) {
      Configuracion().setParametro('tipoUsuario', 'user');
    } else {
      Configuracion().setParametro('tipoUsuario', 'admin');
    }
    notifyListeners();
  }

  Future<bool> _checkTipoUsuario() async {
    String? tipoUsuario = await Configuracion().getParametro('tipoUsuario');
    if (tipoUsuario == null) {
      tipoUsuario = 'user';
      Configuracion().setParametro('tipoUsuario', tipoUsuario);  
    }
    if (tipoUsuario == 'admin') { 
      return true;
    } else {
      return false;
    }
  }
}
