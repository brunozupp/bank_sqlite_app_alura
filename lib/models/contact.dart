import 'dart:convert';

class Contact {
  
  final int id;
  final String name;
  final int accountNumber;

  Contact({
    this.id = 0, 
    required this.name, 
    required this.accountNumber
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'account_number': accountNumber,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map['id'],
      name: map['name'],
      accountNumber: map['account_number'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) => Contact.fromMap(json.decode(source));
}
