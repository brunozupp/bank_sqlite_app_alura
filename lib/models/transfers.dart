import 'package:bank_sqlite_app_alura/models/transfer.dart';
import 'package:flutter/material.dart';

class Transfers extends ChangeNotifier {

  final _transfers = List<Transfer>.empty(growable: true);

  List<Transfer> get transfers => _transfers;

  void add(Transfer transfer) {
    _transfers.add(transfer);
    notifyListeners();
  }
}