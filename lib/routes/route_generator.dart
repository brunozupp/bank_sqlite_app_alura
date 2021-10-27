import 'package:bank_sqlite_app_alura/models/contact.dart';
import 'package:bank_sqlite_app_alura/pages/contacts/contact_form_page.dart';
import 'package:bank_sqlite_app_alura/pages/contacts/contacts_list_page.dart';
import 'package:bank_sqlite_app_alura/pages/dashboard/dashboard_page.dart';
import 'package:bank_sqlite_app_alura/pages/transactions/transaction_form_page.dart';
import 'package:bank_sqlite_app_alura/pages/transactions/transactions_list_page.dart';
import 'package:flutter/material.dart';

class RouteGenerator {

  static Route<dynamic> generateRoutes(RouteSettings settings) {

    final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      
      case '/contacts':
        return MaterialPageRoute(builder: (_) => const ContactsListPage());

      case '/contacts/form':
        
        if(args == null || (args is Contact?) || args is Contact) {
          return MaterialPageRoute(builder: (_) => ContactFormPage(
            contact: args as Contact?,
          ));
        }

        return _errorWrongType();
      
      case '/transactions':
        return MaterialPageRoute(builder: (_) => const TransactionsListPage());

      case '/transactions/form':
        
        if(args is Contact) {
          return MaterialPageRoute(builder: (_) => TransactionFormPage(
            contact: args,
          ));
        }

        return _errorWrongType();
      
      default:
        _routeNotFound();
    }

    return _routeNotFound();
  } 

  static Route<dynamic> _errorWrongType() {
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(
        title: const Text('Erro'),
      ),
      body: const Center(
        child: Text('Erro de tipagem de parametro'),
      ),
    ));
  }

  static Route<dynamic> _routeNotFound() {
    return MaterialPageRoute(builder: (_) => Scaffold(
      appBar: AppBar(
        title: const Text('Não encontrado'),
      ),
      body: const Center(
        child: Text('A página em questão não foi encontrada'),
      ),
    ));
  }
}