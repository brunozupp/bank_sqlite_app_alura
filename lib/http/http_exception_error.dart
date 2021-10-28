import 'dart:io';

class HttpExceptionError implements Exception {
  
  late final String message;
  final int statusCode;

  HttpExceptionError(this.statusCode) {
    message = _errorsHttp(statusCode);
  }
  
  static String _errorsHttp(int statusCode) {
    var errors = {
      HttpStatus.badRequest: "Erro de Bad Request",
      HttpStatus.unauthorized: "Não está autorizado",
      HttpStatus.notFound: "Não foi encontrado",
      HttpStatus.internalServerError: "Erro interno no servidor",
      HttpStatus.conflict: "Ocorreu um conflito com um registro já existente"
    };

    if(errors.containsKey(statusCode)) {
      return errors[statusCode]!;
    }
    
    return "Erro não identificado";
  }
}
