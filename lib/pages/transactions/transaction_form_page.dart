import 'package:bank_sqlite_app_alura/http/webclients/transaction_webclient.dart';
import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/models/transaction.dart';
import 'package:bank_sqlite_app_alura/styles/colors_app.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class TransactionFormPage extends StatelessWidget {

  final Contact contact;

  TransactionFormPage({ 
    Key? key,
    required this.contact
  }) : super(key: key);

  final _valueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final webclient = TransactionWebClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New transaction'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  contact.accountNumber.toString(),
                  style: const TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _valueController,
                      style: const TextStyle(fontSize: 24.0),
                      decoration: const InputDecoration(
                        labelText: 'Valor'
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if(value == null || value.isEmpty) return "Valor obrigatório";

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        child: const Text('Transferir'),
                        style: ElevatedButton.styleFrom(
                          primary: ColorsApp.primaryColor
                        ),
                        onPressed: () async {
                          
                          if(!_formKey.currentState!.validate()) {
                            SnackbarUtils.showSnackbarError(context: context, message: "Erro de validação");
                            return;
                          }

                          final double? value = double.tryParse(_valueController.text);

                          if(value == null) {
                            SnackbarUtils.showSnackbarError(context: context, message: "Erro na conversão do valor");
                            return;
                          }

                          final transactionCreated = Transaction(
                            contact: contact,
                            value: value
                          );

                          final result = await webclient.save(transactionCreated);

                          if(result == null) {
                            SnackbarUtils.showSnackbarError(context: context, message: "Não foi possível salvar");
                            return;
                          }

                          Navigator.of(context).pop(result);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}