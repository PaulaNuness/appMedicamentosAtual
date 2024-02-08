import 'package:flutter1/utils/validar_pruebas_unitarias.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {

  // Expected: <true>
  // Actual: <false> porque o ano nao esta entre 1900 e 2100
//test('isDateValid should return true for a valid date', () {
      //final validations = Validations();
      //expect(validations.isDateValid('31/01/0000'), true);
    //});


  // All tests passed! porque o ano esta entre 1900 e 2100
test('isDateValid should return true for a valid date', () {
      final validations = Validations();
      expect(validations.isDateValid('31/01/2024'), true);
    });



//test('isSexValid should return true for a valid sex', () {
      //final validations = Validations();
      //expect(validations.isSexValid('hombre'), true);
    //});



//test('isSexValid should return true for a valid sex', () {
      //final validations = Validations();
      //expect(validations.isSexValid('gato'), true);
    //});


}
