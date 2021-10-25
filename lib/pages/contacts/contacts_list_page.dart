import 'package:bank_sqlite_app_alura/models/contact.dart';
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
      body: ListView(
        children: const [
          Card(
            child: ListTile(
              title: Text(
                "Alex",
                style: TextStyle(
                  fontSize: 24
                ),
              ),
              subtitle: Text(
                "1000",
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}