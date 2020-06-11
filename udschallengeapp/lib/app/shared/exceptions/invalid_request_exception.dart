class InvalidRequestException implements Exception {
  String cause;
  InvalidRequestException(this.cause);
}
