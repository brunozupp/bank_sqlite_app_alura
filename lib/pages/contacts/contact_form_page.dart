import 'package:bank_sqlite_app_alura/database/dao/contact_dao.dart';
import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/styles/colors_app.dart';
import 'package:bank_sqlite_app_alura/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';

class ContactFormPage extends StatefulWidget {

  final Contact? contact;

  const ContactFormPage({ 
    Key? key,
    this.contact
  }) : super(key: key);

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {

  @override
  void initState() {
    super.initState();

    _fullnameController.text = widget.contact?.name ?? "";
    _accountController.text = widget.contact?.accountNumber.toString() ?? "";
  }

  final _formKey = GlobalKey<FormState>();

  final _fullnameController = TextEditingController();

  final _accountController = TextEditingController();

  final ContactDao _dao = ContactDao();

  var isLoading = false;

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
                validator: (value) {
                  if(value == null || value.isEmpty) {
                    return "Campo obrigatório";
                  }

                  RegExp regex = RegExp(r"[0-9]");

                  if(regex.hasMatch(value)) {
                    return "Não pode conter números, apenas letras";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _accountController,
                decoration: const InputDecoration(
                  labelText: 'Conta',
                ),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  fontSize: 24.0
                ),
                maxLength: 4,
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
              const SizedBox(
                height: 10,
              ),
              IgnorePointer(
                ignoring: isLoading,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: ColorsApp.primaryColor
                    ),
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
                    onPressed: () async {

                      if(!_formKey.currentState!.validate()) {
                        SnackbarUtils.showSnackbarError(context: context, message: "Erro de validação");
                        return;
                      }

                      final String name = _fullnameController.text;
                      final int? accountNumber = int.tryParse(_accountController.text);

                      if(accountNumber == null) {
                        SnackbarUtils.showSnackbarError(context: context, message: "Erro na conversão da conta");
                        return;
                      }

                      final object = Contact(id: widget.contact?.id ?? 0, name: name, accountNumber: accountNumber);

                      setState(() {
                        isLoading = true;
                      });

                      if(widget.contact == null) {
                        await _dao.save(object);
                      } else {
                        await _dao.update(object);
                      }

                      setState(() {
                        isLoading = false;
                      });

                      Navigator.of(context).pop(true);
                    }, 
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}