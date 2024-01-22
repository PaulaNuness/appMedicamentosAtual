class Medicamento {
  String nome;
  int quantidade;
  String unidadeTempo;
  int quantidadeEnvase;
  String recomendacoes;
  List<String> horarios;

  Medicamento({
    required this.nome,
    required this.quantidade,
    required this.unidadeTempo,
    required this.quantidadeEnvase,
    required this.recomendacoes,
    required this.horarios,
  });

  // Método para converter o objeto em um mapa
  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'quantidade': quantidade,
      'unidadeTempo': unidadeTempo,
      'quantidadeEnvase': quantidadeEnvase,
      'recomendacoes': recomendacoes,
      'horarios': horarios.join(','), // Convertendo a lista para uma string
    };
  }

    // Método para criar um objeto Medicamento a partir de um mapa
  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      nome: map['nome'],
      quantidade: map['quantidade'],
      unidadeTempo: map['unidadeTempo'],
      quantidadeEnvase: map['quantidadeEnvase'],
      recomendacoes: map['recomendacoes'],
      horarios: (map['horarios'] as String).split(','), // Convertendo a string de volta para uma lista
    );
  }

    // Getters individuais
  String get getNome => nome;
  int get getQuantidade => quantidade;
  String get getUnidadeTempo => unidadeTempo;
  int get getQuantidadeEnvase => quantidadeEnvase;
  String get getRecomendacoes => recomendacoes;
  List<String> get getHorarios => horarios;
}
