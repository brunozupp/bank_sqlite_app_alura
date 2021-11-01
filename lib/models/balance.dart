import 'package:flutter/cupertino.dart';

class Balance extends ChangeNotifier {

  double value;
  
  Balance({
    required this.value,
  });

  void addValue(double value) {
    this.value += value;
    notifyListeners();
  }

  void subtractValue(double value) {
    this.value -= value;
    notifyListeners();
  }
}
