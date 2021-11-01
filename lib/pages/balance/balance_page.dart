import 'package:bank_sqlite_app_alura/models/balance.dart';
import 'package:bank_sqlite_app_alura/pages/balance/components/balance_item_component.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saldo"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Consumer<Balance>(
                builder: (context,balance,child) {
                  return BalanceItemComponent(
                    balance: balance,
                  );
                },
              )
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed("/deposit/form"), 
                  child: const Text("Depositar")
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pushNamed("/transfers/form"),
                  child: const Text("Transferir")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}