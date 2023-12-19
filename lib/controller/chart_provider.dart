import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class ChartScreenProvider extends ChangeNotifier{
  bool isImageFile(String fileName) {
  var imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
  var extension = path.extension(fileName).toLowerCase();
  return imageExtensions.contains(extension);

}
bool isVideoFile(String fileName) {
  var videoExtensions = [
    '.mkv',
    '.mp4',
    '.avi',
    '.flv',
    '.wmv',
    '.mov',
    '.3gp',
    '.webm'
  ];
  var extension = path.extension(fileName).toLowerCase();
  return videoExtensions.contains(extension);
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