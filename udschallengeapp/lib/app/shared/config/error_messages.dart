///
/// Relates error codes returned from Firebase to the respective message.
///
class ErrorMessages {
  static Map<String, String> _errorCodes = {
    "ERROR_INVALID_EMAIL": "O email informado não é válido",
    "ERROR_WRONG_PASSWORD": "Senha incorreta",
    "ERROR_USER_NOT_FOUND": "Usuário não existe",
    "ERROR_WEAK_PASSWORD": "A senha informada é muito fraca",
    "ERROR_EMAIL_ALREADY_IN_USE": "O email informado já está em uso",
  };

  static String getFrom(String errorCode, {String orElse: ""}) {
    return _errorCodes[errorCode] ?? orElse;
  }
}
