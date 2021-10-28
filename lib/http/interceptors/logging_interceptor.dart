import 'package:flutter/material.dart';
import 'package:http_interceptor/http/interceptor_contract.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint("REQUISIÇÃO");
    debugPrint("BaseUrl: ${data.baseUrl}");
    debugPrint("Url: ${data.url}");
    debugPrint("Body: ${data.body}");
    debugPrint("Headers: ${data.headers}");
    debugPrint("Method: ${data.method.toString()}");
    
    
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint("RESPONSE");
    debugPrint("StatusCode: ${data.statusCode}");
    debugPrint("Url: ${data.url}");
    debugPrint("Body: ${data.body}");
    debugPrint("Headers: ${data.headers}");
    debugPrint("Method: ${data.method.toString()}");
    

    return data;
  }
  
}