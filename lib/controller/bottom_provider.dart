import 'package:flutter/material.dart';

class BottomProvider extends ChangeNotifier {
  int myindex = 0;

  void setIndex(int newIndex) {
    myindex = newIndex;
    notifyListeners();
  }
}
