import 'package:bank_sqlite_app_alura/http/webclient.dart';
import 'package:bank_sqlite_app_alura/routes/route_generator.dart';
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
      onGenerateRoute: RouteGenerator.generateRoutes,
      // routes: {
      //   "/": (context) => const DashboardPage(),
      //   "/contacts": (context) => ContactsListPage(),
      //   "/contacts/form": (context) => ContactFormPage(),
      // },
    );
  }
}