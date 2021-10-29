import 'dart:async';

import 'package:bank_sqlite_app_alura/my_app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  // No caso a zona de erros vai ficar vigiando tudo que está dentro de runApp, no caso, o app inteiro.
  // Caso o Flutter não perceba o erro, esse cara vai perceber e mandar a exceção
  // Seria preciso que tivesse inicializado o firebase antes
  // runZonedGuarded<Future<void>>(() async {
  //   runApp(const MyApp());
  // }, FirebaseCrashlytics.instance.recordError);
}