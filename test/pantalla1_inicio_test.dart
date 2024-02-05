import 'package:flutter_test/flutter_test.dart';
import 'package:flutter1/widgets/pantalla1_inicio.dart';

void main() {
  group('Pantalla1_Inicio', () {
    test('Teste de autenticação bem-sucedido', () async {
      // Crie uma instância da tela de início
      final pantallaInicio = Pantalla1_Inicio();

      // Simule a entrada do usuário (usuário e senha)
      pantallaInicio.usuarioController.text = 'usuario_teste';
      pantallaInicio.contrasenaController.text = 'senha_teste';

      // Execute a lógica de autenticação (neste caso, pressionar o botão de entrada)
      await pantallaInicio.onPressed();

      // Faça as asserções conforme necessário para garantir o comportamento esperado
      expect(Pantalla1_Inicio.id, algumValorEsperado);
      expect(Pantalla1_Inicio.nombre, algumValorEsperado);
      // Adicione mais asserções conforme necessário
    });

    // Adicione mais testes conforme necessário
  });
}
