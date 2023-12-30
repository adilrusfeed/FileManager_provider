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

  void setViewType(bool isList) {
    isListView = isList;
    notifyListeners();
  }

  void setSorted(bool sorted) {
    isSorted = sorted;
    notifyListeners();
  }

  void isListTrue() {
    isListView = true;
    notifyListeners();
  }

  void isListFalse() {
    isListView = false;
    notifyListeners();
  }
  void issortedTrue() {
    isSorted = true;
    notifyListeners();
  }
  
}

  // void popup(){
  //   if (choice == 'gridView') {
  //                 recentProvider.isListView = false;
  //                 } else if (choice == 'listView') {
  //                 recentProvider. isListView = true;
  //                 } else if (choice == 'sort') {
  //                 recentProvider.isSorted = true;
  //                 }
  // }
  

