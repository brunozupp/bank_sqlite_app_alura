import 'package:bank_sqlite_app_alura/http/webclient.dart';
import 'package:bank_sqlite_app_alura/http/webclients/transaction_webclient.dart';
import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/models/transaction.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:bank_sqlite_app_alura/widgets/centered_message.dart';
import 'package:flutter/material.dart';

import 'components/card_item_component.dart';

class TransactionsListPage extends StatefulWidget {
  const TransactionsListPage({ Key? key }) : super(key: key);

  @override
  State<TransactionsListPage> createState() => _TransactionsListPageState();
}

class _TransactionsListPageState extends State<TransactionsListPage> {

  final webclient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Feed de transações"),
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
      body: FutureBuilder<List<Transaction>>(
        future: webclient.findAll(),
        builder: (context, snapshot) {

          if(snapshot.hasError) {
            return const CenteredMessage(
              message: "Erro na execução",
              icon: Icons.error,
              iconSize: 70,
            );
          }

          if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.hasData && snapshot.data!.isEmpty) {
            return const CenteredMessage(
              message: "Lista vazia",
            );
          }

          final transactions = snapshot.data!;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (_,index) {
              return CardItemComponent(
                transaction: transactions[index],  
              );
            },
          );
        }
      ),
    );
  }
}