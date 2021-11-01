import 'package:bank_sqlite_app_alura/models/balance.dart';
import 'package:flutter/material.dart';

class BalanceItemComponent extends StatelessWidget {
  
  final Balance balance;
  
  const BalanceItemComponent({ 
    Key? key, 
    required this.balance 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "R\$ ${balance.value}",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 40
      ),
    );
  }
}