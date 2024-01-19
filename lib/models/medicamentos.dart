class Medicamento {
  int id; // Identificador único do medicamento
  String nome; // Nome do medicamento
  int quantidade; // Quantidade de medicamento
  String unidadeTempo; // Unidade de tempo (DÍAS, MESES, AÑOS)
  int quantidadeEnvase; // Quantidade no envase
  String recomendacoes; // Recomendações relacionadas ao medicamento
  List<String> horarios; // Lista de horários/Alertas

  Medicamento({
    required this.id,
    required this.nome,
    required this.quantidade,
    required this.unidadeTempo,
    required this.quantidadeEnvase,
    required this.recomendacoes,
    required this.horarios,
  });

  // Método para converter a instância da classe em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'unidadeTempo': unidadeTempo,
      'quantidadeEnvase': quantidadeEnvase,
      'recomendacoes': recomendacoes,
      'horarios': horarios.join(','), // Convertendo a lista de horários em uma string separada por vírgulas
    };
  }

  // Método para criar uma instância da classe a partir de um mapa
  factory Medicamento.fromMap(Map<String, dynamic> map) {
    return Medicamento(
      id: map['id'],
      nome: map['nome'],
      quantidade: map['quantidade'],
      unidadeTempo: map['unidadeTempo'],
      quantidadeEnvase: map['quantidadeEnvase'],
      recomendacoes: map['recomendacoes'],
      horarios: (map['horarios'] as String).split(','), // Convertendo a string de horários em uma lista
    );
  }
}
