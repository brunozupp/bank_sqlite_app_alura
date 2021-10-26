import 'package:bank_sqlite_app_alura/database/app_database.dart';
import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/pages/contacts/components/card_item_component.dart';
import 'package:flutter/material.dart';

class ContactsListPage extends StatelessWidget {
  const ContactsListPage({ Key? key }) : super(key: key);
  
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

          final contact = await Navigator.of(context).pushNamed("/contacts/form") as Contact?;
        },
      ),
      body: FutureBuilder<List<Contact>>(
        future: findAll(),
        builder: (context,snapshot) {

          if(snapshot.hasError) {
            return const Center(
              child: Text("Erro na execução"),
            );
          }

          if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if(snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Lista vazia"),
            ); 
          }

          final contacts = snapshot.data!;

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (_,index) {
              return CardItemComponent(
                contact: contacts[index]
              );
            },
          );
        },
      )
    );
  }
}