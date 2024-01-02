import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class VideoProvider extends ChangeNotifier {
  TextEditingController searchController3 = TextEditingController();
    String searchQuery = "";
         


  bool isVideoFile(String fileName) {
    var videoExtensions = [
      '.mkv',
      '.mp4',
      '.avi',
      '.flv',
      '.wmv',
      '.mov',
      '.3gp',
      '.webm',
    ];
    var extension = path.extension(fileName).toLowerCase();
    return videoExtensions.contains(extension);
  }

  void onSearchTextChanged(String query) {
    searchQuery = query;
    notifyListeners();
  }
}
