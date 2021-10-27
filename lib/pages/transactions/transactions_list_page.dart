import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/models/transaction.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

import 'components/card_item_component.dart';

class TransactionsListPage extends StatefulWidget {
  const TransactionsListPage({ Key? key }) : super(key: key);

  @override
  State<TransactionsListPage> createState() => _TransactionsListPageState();
}

final List<Transaction> list = List<Transaction>.empty(growable: true);

class _TransactionsListPageState extends State<TransactionsListPage> {

  @override
  void initState() {
    super.initState();

    list.add(Transaction(value: 1500, contact: Contact(name: "Bruno", accountNumber: 1236)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contatos"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add
        ),
        onPressed: () async {

          final canUpdate = await Navigator.of(context).pushNamed("/contacts/form") as bool?;

          if(canUpdate == true) {
            setState(() {
              SnackbarUtils.showSnackbarSuccess(context: context, message: "Adicionado com sucesso");
            });
          }
        },
      ),
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_,index) {
          return CardItemComponent(
            transaction: list[index],  
          );
        },
      ),
    );
  }
}