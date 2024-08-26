class ApiException implements Exception {
  ApiException(this.code, this.message);
  int? code;
  String? message;
}
