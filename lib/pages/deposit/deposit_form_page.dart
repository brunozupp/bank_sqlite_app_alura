import 'package:bank_sqlite_app_alura/models/balance.dart';
import 'package:bank_sqlite_app_alura/models/transfer.dart';
import 'package:bank_sqlite_app_alura/models/transfers.dart';
import 'package:bank_sqlite_app_alura/styles/colors_app.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DepositFormPage extends StatelessWidget {

  DepositFormPage({ 
    Key? key,
  }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Deposito"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
                    "Depositar"
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

                    Provider.of<Balance>(context, listen: false).addValue(value);

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