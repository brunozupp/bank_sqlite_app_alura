import 'package:bank_sqlite_app_alura/http/webclients/transaction_webclient.dart';
import 'package:bank_sqlite_app_alura/models/transaction.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:bank_sqlite_app_alura/widgets/centered_message_widget.dart';
import 'package:bank_sqlite_app_alura/widgets/progress_widget.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
      body: FutureBuilder<List<Transaction>>(
        future: webclient.findAll(),
        builder: (context, snapshot) {

          if(snapshot.hasError) {
            if (FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled) {
              FirebaseCrashlytics.instance.recordError(snapshot.error, snapshot.stackTrace);
            }
            return const CenteredMessageWidget(
              message: "Erro na execução",
              icon: Icons.error,
              iconSize: 70,
            );
          }

          if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
            return const ProgressWidget();
          }

          if(snapshot.hasData && snapshot.data!.isEmpty) {
            return const CenteredMessageWidget(
              message: "Lista vazia",
            );
          }

          final transactions = snapshot.data!;

          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (_,index) {
              return CardItemComponent(
                transaction: transactions[index],
                onDelete: () async {
                  var result = await webclient.delete(transactions[index].id);

                  if(result) {
                    SnackbarUtils.showSnackbarSuccess(context: context, message: "Sucesso ao deletar");
                    setState(() {
                      
                    });
                  } else {
                    SnackbarUtils.showSnackbarError(context: context, message: "Falha ao deletar");
                  }
                }
              );
            },
          );
        }
      ),
    );
  }
}