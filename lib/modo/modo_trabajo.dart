import 'package:flutter/material.dart';
import 'package:flutter1/models/configuracion.dart';

class ModoTrabajo with ChangeNotifier {
  
  bool _modoLocal = false;
  bool _modoRemoto = false;

  bool get modoLocal => this._modoLocal;
  bool get modoRemoto => this._modoRemoto;
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ModoTrabajo() {
    bool local=false;
    _modoFuncionamientoLocal().then((value) => local=value);
    if (local) {
      this._modoLocal = true;
      this._modoRemoto = false;
    } else {
      this._modoLocal = false;
      this._modoRemoto = true;
    }
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
  set modoLocal(bool value) {
    this._modoLocal = value;
    this._modoRemoto = !value;
    if (value) {
      Configuracion().setParametro('modoTrabajo', 'local');
    } else {
      Configuracion().setParametro('modoTrabajo', 'remoto');
    }
    notifyListeners();
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
  set modoRemoto(bool value) {
    this._modoRemoto = value;
    this._modoLocal = !value;
    if (value) {
      Configuracion().setParametro('modoTrabajo', 'remoto');
    } else {
      Configuracion().setParametro('modoTrabajo', 'local');
    }
    notifyListeners();
  }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<bool> _modoFuncionamientoLocal() async {
    String? modoTrabajo=await Configuracion().getParametro('modoTrabajo');
    if(modoTrabajo==null)
    {
      modoTrabajo='local';
      Configuracion().setParametro('modoTrabajo', modoTrabajo);  
    }
    if(modoTrabajo=='local')
    { 
      return true;
    }
    else
    {
      return false;
    }
  }
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////
}