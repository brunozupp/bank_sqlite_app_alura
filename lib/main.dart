import 'dart:async';

import 'package:bank_sqlite_app_alura/models/balance.dart';
import 'package:bank_sqlite_app_alura/models/transfers.dart';
import 'package:bank_sqlite_app_alura/my_app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Balance(value: 0.0),
      ),
      ChangeNotifierProvider(
        create: (context) => Transfers(),
      )
    ],
    child: const MyApp(),
  ));

  // runApp(ChangeNotifierProvider(
  //   create: (context) => Balance(value: 0.0),
  //   child: const MyApp(),
  // ));

  // No caso a zona de erros vai ficar vigiando tudo que está dentro de runApp, no caso, o app inteiro.
  // Caso o Flutter não perceba o erro, esse cara vai perceber e mandar a exceção
  // Seria preciso que tivesse inicializado o firebase antes
  // runZonedGuarded<Future<void>>(() async {
  //   runApp(const MyApp());
  // }, FirebaseCrashlytics.instance.recordError);
}