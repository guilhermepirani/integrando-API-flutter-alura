import 'dart:convert';

import 'package:http/http.dart';

import '../../models/transaction.dart';
import '../webclient.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(buildUri('transactions'))
        .timeout(const Duration(seconds: 5));

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction) async {
    final Response response = await client.post(
      buildUri('transactions'),
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: jsonEncode(transaction.toJson()),
    );
    return Transaction.fromJson(jsonDecode(response.body));
  }
}
