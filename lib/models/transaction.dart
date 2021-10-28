import 'dart:convert';

import 'package:bank_sqlite_app_alura/models/contact.dart';

class Transaction {
  
  final String? id;
  final double value;
  final Contact contact;
  
  Transaction({
    this.id,
    required this.value,
    required this.contact,
  });

  Map<String, dynamic> toMap() {
    return {
      if(id != null && id!.isNotEmpty) 'id': id,
      'value': value,
      'contact': contact.toMap(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      value: map['value'],
      contact: Contact.fromMap(map['contact']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) => Transaction.fromMap(json.decode(source));
}
