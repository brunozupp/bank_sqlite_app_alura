import 'dart:convert';
import 'dart:io';

import 'package:bank_sqlite_app_alura/models/transaction.dart';

import '../webclient.dart';

class TransactionWebClient {

  Future<List<Transaction>> findAll() async {

    // Timeout é importante para evitar da tela ficar em loading infinito quando o serviço não está rápido, assim evitando
    // a perca de recursos por parte do usuário. Ai lança uma exceção de timeout
    var result = await client.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 5));
    
    final List decodedJson = jsonDecode(result.body);

    final List<Transaction> transactions = decodedJson.map((e) => Transaction.fromMap(e)).toList();

    return transactions;
  }

  Future<Transaction?> save(Transaction transaction) async {

    final result = await client.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
        "password": "1000"
      },
      body: transaction.toJson(),
    );

    if(result.statusCode == HttpStatus.ok) {
      return Transaction.fromJson(result.body);
    }

    return null;
  }

}