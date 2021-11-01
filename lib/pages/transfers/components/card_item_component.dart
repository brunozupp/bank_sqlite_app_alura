import 'package:bank_sqlite_app_alura/models/transfer.dart';
import 'package:flutter/material.dart';

class CardItemComponent extends StatelessWidget {

  final Transfer transfer;

  const CardItemComponent({ 
    Key? key, 
    required this.transfer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          "Conta: ${transfer.accountNumber.toString()}",
          style: const TextStyle(
            fontSize: 24
          ),
        ),
        subtitle: Text(
          "Valor: ${transfer.accountNumber.toString()}",
          style: const TextStyle(
            fontSize: 16
          ),
        ),
      ),
    );
  }
}