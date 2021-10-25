import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/styles/colors_app.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class ContactFormPage extends StatelessWidget {
  ContactFormPage({ Key? key }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _fullnameController = TextEditingController();
  final _accountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _fullnameController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                ),
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  fontSize: 24.0
                ),
              ),
              TextFormField(
                controller: _fullnameController,
                decoration: const InputDecoration(
                  labelText: 'Conta',
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 24.0
                ),
                maxLength: 4,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorsApp.primaryColor
                  ),
                  child: const Text(
                    "Salvar"
                  ),
                  onPressed: () {
                    final String name = _fullnameController.text;
                    final int? accountNumber = int.tryParse(_accountController.text);

                    if(accountNumber == null) {
                      SnackbarUtils.showSnackbarError(context: context, message: "Erro na conversão da conta");
                      return;
                    }

                    //final contact = Contact(name: name, accountNumber: accountNumber);

                    //Navigator.of(context).pop(contact);
                  }, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}