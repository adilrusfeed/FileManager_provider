import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class DocumentProvider extends ChangeNotifier {
  TextEditingController searchcontroller5 = TextEditingController();
  String searchQuery = "";
  

  void onSearchTextChanged(String query) {
    searchQuery = query;
    notifyListeners();
  }

  bool isDocumentFile(String fileName) {
    var documentExtensions = [
      '.pdf',
      '.doc',
      '.txt',
      '.ppt',
      '.docx',
      '.pptx',
      '.xlxs',
      '.xls',
      '.html'
    ];
    var extension = path.extension(fileName).toLowerCase();
    return documentExtensions.contains(extension);
  }
}
