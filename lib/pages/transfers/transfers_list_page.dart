import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/models/transfers.dart';
import 'package:bank_sqlite_app_alura/pages/transfers/components/card_item_component.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransfersListPage extends StatelessWidget {

  const TransfersListPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transferências"),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add
        ),
        onPressed: () async {
          Navigator.of(context).pushNamed("/transfers/form");
        },
      ),
      body: Consumer<Transfers>(
        builder: (context, value, child) {

          final transfers = value.transfers;

          return ListView.builder(
            itemCount: transfers.length,
            itemBuilder: (_,index) {
              return CardItemComponent(
                transfer: transfers[index],
              );
            },
          );
        }
      ),
    );
  }
}