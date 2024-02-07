import 'package:flutter1/utils/validar_pruebas_unitarias.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
test('isDateValid should return true for a valid date', () {
      final validations = Validations();
      expect(validations.isDateValid('31/01/2022'), true);
    });

test('isSexValid should return true for a valid sex', () {
      final validations = Validations();
      expect(validations.isSexValid('hombre'), true);
    });


}
