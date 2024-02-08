import 'package:flutter/material.dart';
import 'package:flutter1/widgets/Registro_hecho.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {//tenemos una prueba 
  testWidgets('Teste do RegistroHecho Widget', (WidgetTester tester) async {
    // Construir o widget
    await tester.pumpWidget(MaterialApp(home: RegistroHecho()));

    // Verificar se o texto 'Muy bien!!! Registro hecho' está presente na tela
    expect(find.text('Muy bien!!! Registro hecho'), findsOneWidget);

  });
}
