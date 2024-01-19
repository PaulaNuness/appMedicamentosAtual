class Usuario {
  int? _id; // ID do usuário, pode ser nulo se ainda não estiver definido
  late String _nombre;
  late String _contrasena;
  late String _fechanacimento;
  late String _sexo;

  //constructor
  Usuario(String nombre,String contrasena,String fechanacimento,String sexo) {
    this._id=0;
    this._nombre = '';
    this._contrasena = '';
    this._fechanacimento = '';
    this._sexo = '';
 
  }

  //constructor sin id
  Usuario.withoutId(String nombre,String contrasena,String fechanacimento,String sexo){
    this._nombre=nombre;
    this._contrasena=contrasena;
    this._fechanacimento=fechanacimento;
    this._sexo=sexo;
  }
 
  //constructor con id
  Usuario.withtId(int id,String nombre,String contrasena,String fechanacimento,String sexo){
    this._id=id;
    this._nombre=nombre;
    this._contrasena=contrasena;
    this._fechanacimento=fechanacimento;
    this._sexo=sexo;
 
  }
 

  Usuario.fromMap(dynamic obj) {
    this._id = obj['id'];
    this._nombre = obj['nombre'];
    this._contrasena = obj['contrasena'];
    this._fechanacimento = obj['fechanacimento'];
    this._sexo = obj['sexo'];
  }

  //Getters
  int? get id => _id;
  String get nombre => _nombre;
  String get contrasena => _contrasena;
  String get fechanacimento => _fechanacimento;
  String get sexo => _sexo;

  //Setters
  set nombre(String nombre)
  {
    this._nombre = nombre;
  }
  set contrasena(String contrasena)
  {
    this._contrasena = contrasena;
  }
  set fechanacimento(String fechanacimento)
  {
    this._fechanacimento = fechanacimento;
  }
  set sexo(String sexo)
  {
    this._sexo = sexo;
  }

  //Metodo para convertir un objeto de tipo Usuario a Map
  Map<String, dynamic> toMap()
  {
    var map = new Map<String, dynamic>();
    if((id != null && id != 0))
    {
      map['id'] = _id;
    }
    map['nombre'] = _nombre;
    map['contrasena'] = _contrasena;
    map['fechanacimento'] = _fechanacimento;
    map['sexo'] = _sexo;
    return map;
  }
 

}
