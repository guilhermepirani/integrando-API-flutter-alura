import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:persistencia_flutter_alura/models/contact.dart';
import 'package:persistencia_flutter_alura/models/transaction.dart';

import 'logging_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [
    LoggingInterceptor(),
  ],
);

Uri buildUri(String urlPath) {
  final Uri _uri =
      Uri(scheme: 'http', host: '192.168.0.4', port: 8080, path: urlPath);
  return _uri;
}

Future<List<Transaction>> findAll() async {
  final Response response = await client
      .get(buildUri('transactions'))
      .timeout(const Duration(seconds: 5));
  final List<dynamic> decodedJson = jsonDecode(response.body);
  final List<Transaction> transactions = [];
  for (Map<String, dynamic> transactionJson in decodedJson) {
    final Map<String, dynamic> contactJson = transactionJson['contact'];
    final Transaction transaction = Transaction(
      transactionJson['value'],
      Contact(
        0,
        contactJson['name'],
        contactJson['accountNumber'],
      ),
    );
    transactions.add(transaction);
  }
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber
    }
  };

  final Response response = await client.post(
    buildUri('transactions'),
    headers: {
      'Content-type': 'application/json',
      'password': '1000',
    },
    body: jsonEncode(transactionMap),
  );
  Map<String, dynamic> responseJson = jsonDecode(response.body);
  final Map<String, dynamic> contactJson = responseJson['contact'];
  return Transaction(
    responseJson['value'],
    Contact(
      0,
      contactJson['name'],
      contactJson['accountNumber'],
    ),
  );
}
