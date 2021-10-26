import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/utils/modal_utils.dart';
import 'package:flutter/material.dart';

class CardItemComponent extends StatelessWidget {

  final Contact contact;
  final Future<int> Function(int) delete;
  final Future<int> Function(Contact) update;

  const CardItemComponent({ 
    Key? key, 
    required this.contact, 
    required this.delete, 
    required this.update, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(
            fontSize: 24
          ),
        ),
        subtitle: Text(
          contact.accountNumber.toString(),
          style: const TextStyle(
            fontSize: 16
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () async {
                await update(contact);
              },
              icon: const Icon(
                Icons.edit
              ),
            ),
            IconButton(
              onPressed: () async {
                final canDelete = await ModalUtils.showModalConfirmation(
                  context, 
                  message: "Ação de deletar não poderá ser desfeita"
                );

                if(canDelete != true) return;

                await delete(contact.id!);
              }, 
              icon: const Icon(
                Icons.delete
              ),
            ),
          ],
        ),
      ),
    );
  }
}