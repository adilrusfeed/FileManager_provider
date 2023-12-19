import 'package:flutter/material.dart';

class RecentScreenProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isListView = true;
  bool isSorted = false;
  String searchQuery = "";

  void onSearchTextChanged(String query) {
    searchQuery = query;
    notifyListeners();
  }
}
