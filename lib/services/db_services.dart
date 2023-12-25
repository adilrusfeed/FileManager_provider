import 'package:file_manager/model/data_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbService {
  Future<List<FileModel>> pickFile(PlatformFile selectedFile) async {
    final fileDB = await Hive.openBox<FileModel>("FileModel_db");
    return fileDB.values.toList();
  }

  Future<void> getAlldata() async {
    final fileDB = await Hive.openBox<FileModel>("FileModel_db");
    return fileDB.add(value)
  }
}
