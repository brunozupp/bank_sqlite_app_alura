import 'package:bank_sqlite_app_alura/models/transaction.dart';
import 'package:flutter/material.dart';

class CardItemComponent extends StatelessWidget {

  final Transaction transaction;
  final VoidCallback onDelete;

  const CardItemComponent({ 
    Key? key, 
    required this.transaction, 
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          transaction.contact.name,
          style: const TextStyle(
            fontSize: 24
          ),
        ),
        subtitle: Text(
          transaction.value.toString(),
          style: const TextStyle(
            fontSize: 16
          ),
        ),
        leading: const Icon(
          Icons.monetization_on
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete
          ),
          onPressed: onDelete, 
        ),
      ),
    );
  }
}