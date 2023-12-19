import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class AudioProvider extends ChangeNotifier{
  TextEditingController searchcontroller4 = TextEditingController();
   String searchQuery = "";
     bool isAscending = true;

  void onSearchTextchanged(String query) {
    searchQuery = query;
    notifyListeners();
  }
   bool isAudioFile(String fileName) {
    var audioExtensions = [
      '.wav',
      '.aac',
      '.mp3',
      '.ogg',
      '.wma',
      '.flac',
      '.m4a',
      '.opus'
    ];
    var extension = path.extension(fileName).toLowerCase();
    return audioExtensions.contains(extension);
  }


}