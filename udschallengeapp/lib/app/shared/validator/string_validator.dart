class StringValidator {
  String field;
  int minSize;

  StringValidator(this.field, [int minSize]);

  String validate(String value) {
    if (value?.isEmpty != false) {
      return "Campo $field é obrigatório";
    }

    if (minSize != null && value.length < minSize) {
      return "Tamanho mínimo é $minSize";
    }

    return null;
  }
}
