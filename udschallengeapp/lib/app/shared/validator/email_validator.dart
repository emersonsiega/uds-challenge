class EmailValidator {
  String field;
  static const String _pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  EmailValidator(this.field);

  String validate(String value) {
    if (value?.isEmpty != false) {
      return "Campo $field é obrigatório";
    }

    RegExp regExp = new RegExp(_pattern);
    if (!regExp.hasMatch(value)) {
      return "Campo $field é inválido";
    }

    return null;
  }
}
