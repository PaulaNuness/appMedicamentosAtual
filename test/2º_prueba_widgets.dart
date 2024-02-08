import 'package:flutter/material.dart';
import 'package:flutter1/widgets/pantalla7_borrar_medicamento.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Teste de presença do botão "Sair"', (WidgetTester tester) async {
    // Monta a tela do widget de teste
    await tester.pumpWidget(MaterialApp(home: pantalla7_borrar_medicamiento()));

    // Verifica se o botão "Sair" está presente na tela
    expect(find.widgetWithText(ElevatedButton, 'Sair'), findsOneWidget);
  });
}
