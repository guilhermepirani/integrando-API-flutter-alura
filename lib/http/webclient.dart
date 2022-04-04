import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    // print('Request');
    // print('url: ${data.baseUrl}');
    // print('headers: ${data.headers}');
    // print('body ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    // print('Response');
    // print('StatusCode: ${data.statusCode}');
    // print('headers: ${data.headers}');
    // print('body ${data.body}');
    return data;
  }
}

void findAll() async {
  final Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
  );
  final Uri _url = Uri(
    scheme: 'http',
    host: '192.168.0.4',
    port: 8080,
    path: 'transactions',
  );
  final Response response = await client.get(_url);
  response.body;
}
