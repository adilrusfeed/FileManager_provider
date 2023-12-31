// ignore_for_file: avoid_print

import 'package:file_manager/model/data_model.dart';
import 'package:file_manager/services/db_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

class DbProvider extends ChangeNotifier {
  List<FileModel> recentFiles = [];
  DbServices dbServices = DbServices();

  Future<void> getAllData() async {
    recentFiles = await dbServices.getAllData();
    notifyListeners();
  }

  Future<void> pickFile(PlatformFile selectedFile) async {
    await dbServices.pickFile(selectedFile);
    await getAllData();
    notifyListeners();
  }

  Future<void> deleteFile(FileModel file) async {
    await dbServices.deleteFile(file);
    await getAllData();
    notifyListeners();
  }

  Future<void> renameFile1(int index, FileModel newValue) async {
    await dbServices.renameFile1(index, newValue);
    await getAllData();
    notifyListeners();
  }

  Future<void> openFile(FileModel file) async {
    final filePath = file.filePath;
    final fileName = file.fileName;

    try {
      await OpenFile.open(filePath);
      print(fileName);
    } catch (error) {
      print(error);
    }
  }
}
