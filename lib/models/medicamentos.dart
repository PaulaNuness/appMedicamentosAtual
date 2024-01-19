class Medicamento {
  int? _id; // Identificador único do medicamento
  late String _nome; // Nome do medicamento
  late int _quantidade; // Quantidade de medicamento
  late String _unidadeTempo; // Unidade de tempo (DÍAS, MESES, AÑOS)
  late int _quantidadeEnvase; // Quantidade no envase
  late String _recomendacoes; // Recomendações relacionadas ao medicamento
  late List<String> _horarios; // Lista de horários/Alertas

//constructor
Medicamento(){
    this._id=0;
    this._nome = '';
    this._quantidade=0;
    this._unidadeTempo = '';
    this._quantidadeEnvase = 0;
    this._recomendacoes = '';
    this._horarios=[];
  }
  
  ///construtor sin id
 Medicamento.withoutId(
  this._nome,
  this._quantidade,
  this._unidadeTempo,
  this._quantidadeEnvase,
  this._recomendacoes,
  List<String> horarios, // Adiciona o tipo de lista como parâmetro
) : _horarios = horarios ?? []; // Inicializa _horarios com a lista fornecida ou uma lista vazia se nenhuma for fornecida


  Medicamento.withId( 
  this._id,
  this._nome,
  this._quantidade,
  this._unidadeTempo,
  this._quantidadeEnvase,
  this._recomendacoes,
  List<String> horarios, // Adiciona o tipo de lista como parâmetro
) : _horarios = horarios ?? []; // Inicializa _horarios com a lista fornecida ou uma lista vazia se nenhuma for fornecida


  //construtor con Map
  Medicamento.fromMap(Map<String, dynamic> map) {
  this._id = (map['id'] != null) ? map['id'] : null;
  this._nome = (map['nome'] != null) ? map['nome'] : '';
  this._quantidade = (map['quantidade'] != null) ? map['quantidade'] : 0;
  this._unidadeTempo = (map['unidadeTempo'] != null) ? map['unidadeTempo'] : '';
  this._quantidadeEnvase = (map['quantidadeEnvase'] != null) ? map['quantidadeEnvase'] : 0;
  this._recomendacoes = (map['recomendacoes'] != null) ? map['recomendacoes'] : '';

  // Verifique se 'horarios' não é nulo e é uma String antes de dividir
  this._horarios = (map['horarios'] != null && map['horarios'] is String)
      ? (map['horarios'] as String).split(',')
      : [];
}


  // Método para converter a instância da classe em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'nome': _nome,
      'quantidade': _quantidade,
      'unidadeTempo': _unidadeTempo,
      'quantidadeEnvase': _quantidadeEnvase,
      'recomendacoes': _recomendacoes,
      'horarios': _horarios.join(','), // Convertendo a lista de horários em uma string separada por vírgulas
    };
  }

   // Getters
  int? get id => _id;
  String get nome => _nome;
  int get quantidade => _quantidade;
  String get unidadeTempo => _unidadeTempo;
  int get quantidadeEnvase => _quantidadeEnvase;
  String get recomendacoes => _recomendacoes;
  List<String> get horarios => _horarios;

  // Setters
  set nome(String nome) {
    _nome = nome;
  }

  set quantidade(int quantidade) {
    _quantidade = quantidade;
  }

  set unidadeTempo(String unidadeTempo) {
    _unidadeTempo = unidadeTempo;
  }

  set quantidadeEnvase(int quantidadeEnvase) {
    _quantidadeEnvase = quantidadeEnvase;
  }

  set recomendacoes(String recomendacoes) {
    _recomendacoes = recomendacoes;
  }

  set horarios(List<String> horarios) {
    _horarios = horarios;
  }


}
