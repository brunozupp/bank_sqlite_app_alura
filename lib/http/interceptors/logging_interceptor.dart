import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print("REQUISIÇÃO");
    print("BaseUrl: ${data.baseUrl}");
    print("Url: ${data.url}");
    print("Body: ${data.body}");
    print("Headers: ${data.headers}");
    print("Method: ${data.method.toString()}");
    
    
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print("RESPONSE");
    print("StatusCode: ${data.statusCode}");
    print("Url: ${data.url}");
    print("Body: ${data.body}");
    print("Headers: ${data.headers}");
    print("Method: ${data.method.toString()}");
    

    return data;
  }
  
}