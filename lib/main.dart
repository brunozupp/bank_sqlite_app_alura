import 'package:bank_sqlite_app_alura/pages/contacts/contact_form_page.dart';
import 'package:bank_sqlite_app_alura/pages/contacts/contacts_list_page.dart';
import 'package:bank_sqlite_app_alura/pages/dashboard/dashboard_page.dart';
import 'package:bank_sqlite_app_alura/styles/colors_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ColorsApp.primaryColor,
        appBarTheme: const AppBarTheme(
          color: ColorsApp.primaryColor,
          centerTitle: true
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: ColorsApp.primaryColor
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const DashboardPage(),
        "/contacts": (context) => const ContactsListPage(),
        "/contacts/form": (context) => ContactFormPage(),
      },
    );
  }
}