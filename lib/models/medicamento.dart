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
}
