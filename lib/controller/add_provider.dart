import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class AddScreenProvider extends ChangeNotifier {
  List<PlatformFile>? selectedFiles;

  void setFiles(List<PlatformFile>? files) {
    selectedFiles = files;
    notifyListeners();
  }

  void removeFile(int index) {
    selectedFiles?.removeAt(index);
    notifyListeners();
  }

  Future<FilePickerResult?> pickFiless() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
      );
      return result;
    } catch (e) {
      print("Error picking files: $e");

      return null;
    }
  }
}
