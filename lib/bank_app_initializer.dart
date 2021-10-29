import 'package:bank_sqlite_app_alura/pages/dashboard/dashboard_page.dart';
import 'package:bank_sqlite_app_alura/widgets/progress_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BankAppInitializer extends StatelessWidget {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  BankAppInitializer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
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
}