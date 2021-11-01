import 'package:bank_sqlite_app_alura/database/dao/contact_dao.dart';
import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/models/transfer.dart';
import 'package:bank_sqlite_app_alura/models/transfers.dart';
import 'package:bank_sqlite_app_alura/styles/colors_app.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransferFormPage extends StatelessWidget {

  final Transfer? transfer;

  TransferFormPage({ 
    Key? key,
    this.transfer
  }) : super(key: key) {
    _valueController.text = transfer?.value.toString() ?? "";
    _accountNumberController.text = transfer?.accountNumber.toString() ?? "";
  }

  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  final _accountNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nova Transferência"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _accountNumberController,
                decoration: const InputDecoration(
                  labelText: 'Número da conta',
                ),
                maxLength: 4,
                keyboardType: TextInputType.name,
                style: const TextStyle(
                  fontSize: 24.0
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }

                  RegExp regex = RegExp(r"[a-zA-Z]");

                  if(regex.hasMatch(value)) {
                    return "Não pode conter letras, apenas números";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _valueController,
                decoration: const InputDecoration(
                  labelText: 'Valor',
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 24.0
                ),
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }

                  RegExp regex = RegExp("[a-zA-Z]");

                  if(regex.hasMatch(value)) return "Não pode conter letras, apenas números";

                  final valueParsed = int.parse(value);

                  if(valueParsed < 0) return "Valor não pode ser menor que 0";

                  if(regex.hasMatch(value)) {
                    return "Não pode conter letras, apenas números";
                  }

                  return null;
                },
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
                    "Transferir"
                  ),
                  onPressed: () async {

                    if(!_formKey.currentState!.validate()) {
                      SnackbarUtils.showSnackbarError(context: context, message: "Erro de validação");
                      return;
                    }

                    final double? value = double.tryParse(_valueController.text);
                    final int? accountNumber = int.tryParse(_accountNumberController.text);

                    if(accountNumber == null || value == null) {
                      SnackbarUtils.showSnackbarError(context: context, message: "Erro na conversão dos valores");
                      return;
                    }

                    final object = Transfer(value: value, accountNumber: accountNumber);

                    Provider.of<Transfers>(context, listen: false).add(object);

                    Navigator.of(context).pop();
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