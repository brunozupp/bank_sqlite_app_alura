import 'package:bank_sqlite_app_alura/database/dao/contact_dao.dart';
import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/pages/contacts/components/card_item_component.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class ContactsListPage extends StatefulWidget {
  const ContactsListPage({ Key? key }) : super(key: key);

  @override
  State<ContactsListPage> createState() => _ContactsListPageState();
}

class _ContactsListPageState extends State<ContactsListPage> {

  final ContactDao _dao = ContactDao();

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
      body: FutureBuilder<List<Contact>>(
        future: _dao.findAll(),
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
                contact: contacts[index],
                onTap: () async {
                  final isSuccess = await Navigator.of(context).pushNamed("/transactions/form", arguments: contacts[index]);

                  if(isSuccess != null) {
                    SnackbarUtils.showSnackbarSuccess(context: context, message: "Transação realizada com sucesso");
                  }
                },
                delete: (id) async {
                  var rowsAffected = await _dao.remove(id);

                  if(rowsAffected > 0) {
                    SnackbarUtils.showSnackbarSuccess(context: context, message: "Deletado com sucesso");
                    setState(() {});
                  } else {
                    SnackbarUtils.showSnackbarError(context: context, message: "Não foi possível deletar");
                  }

                  return rowsAffected;
                },
                update: (contact) async {

                  final canUpdate = await Navigator.of(context).pushNamed("/contacts/form", arguments: contact) as bool?;

                  if(canUpdate != true) return 0;

                  var rowsAffected = await _dao.update(contact);

                  if(rowsAffected > 0) {
                    SnackbarUtils.showSnackbarSuccess(context: context, message: "Editado com sucesso");
                    setState(() {});
                  } else {
                    SnackbarUtils.showSnackbarError(context: context, message: "Não foi possível editar");
                  }

                  return rowsAffected;
                },
              );
            },
          );
        },
      )
    );
  }
}