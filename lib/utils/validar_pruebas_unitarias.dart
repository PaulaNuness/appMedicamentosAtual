class Validations {
  bool isDateValid(String date) {
    RegExp regex =
        RegExp(r'^([1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$');
    return regex.hasMatch(date);
  }

  bool isMonthValid(String date) {
    List<String> dateParts = date.split('/');
    if (dateParts.length == 3) {
      try {
        int month = int.parse(dateParts[1]);
        return month >= 1 && month <= 12;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  bool isYearValid(String date) {
    List<String> dateParts = date.split('/');
    if (dateParts.length == 3) {
      try {
        int year = int.parse(dateParts[2]);
        return year >= 1900 && year <= 2100;
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  bool isSexValid(String sex) {
    return ['hombre', 'mujer'].contains(sex.toLowerCase());
  }
}
