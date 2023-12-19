import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class ImagesProvider extends ChangeNotifier {
  TextEditingController searchcontroller2 = TextEditingController();
  String searchQuery = "";
  bool isAscending = true;

  void onSearchTextChanged(String query) {
    searchQuery = query;
    notifyListeners();
  }

  bool isImageFile(String fileName) {
    var imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
    var extension = path.extension(fileName).toLowerCase();
    return imageExtensions.contains(extension);
  }
}
