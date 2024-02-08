class Validations {
  //Esse metodo verifica se a string date fornecida está em um formato de data válido. 
  //RegExp regex = RegExp(r'^([1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$')    Isso define uma expressão regular (regex) que corresponde a um padrão específico de data.A expressão regular r'^([1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$' é dividida em três partes separadas por /.
  //A primeira parte ([1-9]|[12][0-9]|3[01]) corresponde ao dia do mês. Pode ser qualquer número de 1 a 31.
  //A segunda parte (0[1-9]|1[0-2]) corresponde ao mês. Pode ser qualquer número de 01 a 12.
  //A terceira parte \d{4} corresponde ao ano. Deve ter exatamente quatro dígitos e estra entre 1900 e 2100
  //Ele retorna true se a string corresponder à expressão regular (ou seja, se estiver em um formato de data válido) e false caso contrário.
  bool isDateValid(String date) {
  RegExp regex =
      RegExp(r'^([1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/(19\d{2}|20\d{2}|2100)$');
  return regex.hasMatch(date);
}


  bool isSexValid(String sex) {
    return ['hombre', 'mujer'].contains(sex.toLowerCase());
  }
}
