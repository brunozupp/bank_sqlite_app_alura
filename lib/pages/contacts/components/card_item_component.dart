import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:flutter/material.dart';

class CardItemComponent extends StatelessWidget {

  final Contact contact;

  const CardItemComponent({ 
    Key? key, 
    required this.contact, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(
            fontSize: 16
          ),
        ),
      ),
    );
  }
}