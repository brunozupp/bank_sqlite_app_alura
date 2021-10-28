import 'dart:io';

class HttpExceptionError implements Exception {
  
  late final String message;
  final int statusCode;

  HttpExceptionError(this.statusCode) {
    message = _errorsHttp[statusCode] ?? "Erro não identificado";
  }

  
  static const Map<int,String> _errorsHttp = {
    HttpStatus.badRequest: "Erro de Bad Request",
    HttpStatus.unauthorized: "Não está autorizado",
    HttpStatus.notFound: "Não foi encontrado",
    HttpStatus.internalServerError: "Erro interno no servidor"
  };
}
