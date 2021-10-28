import 'dart:async';

import 'package:bank_sqlite_app_alura/http/http_exception_error.dart';
import 'package:bank_sqlite_app_alura/http/webclients/transaction_webclient.dart';
import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/models/transaction.dart';
import 'package:bank_sqlite_app_alura/styles/colors_app.dart';
import 'package:bank_sqlite_app_alura/utils/modal_utils.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TransactionFormPage extends StatefulWidget {

  final Contact contact;

  const TransactionFormPage({ 
    Key? key,
    required this.contact
  }) : super(key: key);

  @override
  State<TransactionFormPage> createState() => _TransactionFormPageState();
}

class _TransactionFormPageState extends State<TransactionFormPage> {

  // Idempotência - evitando erro de duplicidade com o UUID
  // O fluxo que eu tinha feito evitaria esse erro
  final String transctionId = const Uuid().v4();

  final _valueController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final webclient = TransactionWebClient();

  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova transação'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.contact.name,
                style: const TextStyle(
                  fontSize: 24.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  widget.contact.accountNumber.toString(),
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

                        RegExp regex = RegExp("[a-zA-Z]");

                        if(regex.hasMatch(value)) return "Não pode conter letras, apenas números";

                        final valueParsed = double.parse(value);

                        if(valueParsed < 0.0) return "Valor não pode ser menor que 0";

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    IgnorePointer(
                      ignoring: isLoading,
                      child: SizedBox(
                        width: double.maxFinite,
                        child: ElevatedButton(
                          child: !isLoading
                            ? const Text(
                              "Transferir"
                            )
                            : const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
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

                            var password = await ModalUtils.showModalGetAuthentication(context);

                            if(password == null || password.isEmpty) {
                              SnackbarUtils.showSnackbarError(context: context, message: "A senha não pode ser vazia");
                              return;
                            }

                            final transactionCreated = Transaction(
                              id: transctionId,
                              contact: widget.contact,
                              value: value
                            );

                            setState(() {
                              isLoading = true;
                            });

                            // Tem que colocar a TimeoutException vindo primeiro pois ela é mais especifica
                            final result = await webclient.save(transactionCreated, password)
                              .catchError((error) {
                                SnackbarUtils.showSnackbarError(context: context, message: "Tempo de resposta muito elevado");
                              }, test: (e) => e is TimeoutException) // Testando para ter uma segurança a mais ao ter passado uma exceção
                              .catchError((error) {
                                SnackbarUtils.showSnackbarError(context: context, message: error.message);
                              }, test: (e) => e is HttpExceptionError)
                              .catchError((error) {
                                SnackbarUtils.showSnackbarError(context: context, message: "Erro desconhecido");
                              }, test: (e) => e is Exception);
                              
                            setState(() {
                              isLoading = false;
                            });

                            if(result != null) {
                              Navigator.of(context).pop(result);
                            }
                          },
                        ),
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