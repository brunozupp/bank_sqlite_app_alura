import 'package:bank_sqlite_app_alura/http/interceptors/logging_interceptor.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http/http.dart';

final Client client = InterceptedClient.build(interceptors: [
  LoggingInterceptor()
]);

const String baseUrl = "http://10.0.2.2:8080/transactions";
