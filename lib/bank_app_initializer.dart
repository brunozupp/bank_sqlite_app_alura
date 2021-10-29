import 'package:bank_sqlite_app_alura/pages/dashboard/dashboard_page.dart';
import 'package:bank_sqlite_app_alura/widgets/progress_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;


class BankAppInitializer extends StatelessWidget {

  const BankAppInitializer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: initializeFirebase(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Erro'),
            ),
            body: const Center(
              child: Text('Erro na inicialização do Firebase'),
            ),
          ); 
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return const DashboardPage();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const ProgressWidget();
      },
    );
  }

  Future<FirebaseApp> initializeFirebase() async {
    final initialization = await Firebase.initializeApp();

    if(kDebugMode) {
      // Force disable Crashlytics collection while doing every day development.
      // Temporarily toggle this to true if you want to test crash reporting in your app.
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    } else {
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      
      // Sempre que identificar um erro de aplicativo, manda para o crashlytics
      // Se tiver um erro de Dart o Flutter se perde pois é uma camada acima dele. Aí que entra o ZonedErrors.
      // Verificar o arquivo main.dart para mais detalhes desse ZonedErrors
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      FirebaseCrashlytics.instance.setUserIdentifier("IdentificadorDoUsuario");
    }

    return initialization;
  }
}