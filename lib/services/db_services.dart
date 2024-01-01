import 'package:file_manager/model/data_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbServices {
  Future<List<FileModel>> getAllData() async {
    final fileDB = await Hive.openBox<FileModel>('FileModel_db');
    return fileDB.values.toList();
  }

  Future<void> pickFile(PlatformFile selectedFile) async {
    final fileDB = await Hive.openBox<FileModel>('FileModel_db');
    final file = FileModel(
      id: DateTime.now().millisecondsSinceEpoch,
      fileName: selectedFile.name,
      filePath: selectedFile.path ?? '',
    );

    await fileDB.add(file);
  }

  Future<void> deleteFile(FileModel file) async {
    final fileDB = await Hive.openBox<FileModel>('FileModel_db');
    final index =
        fileDB.values.toList().indexWhere((element) => element.id == file.id);
    if (index != -1) {
      fileDB.deleteAt(index);
    }
  }

  Future<void> renameFile1(int index, FileModel newValue) async {
    final fileDB = await Hive.openBox<FileModel>('FileModel_db');
    fileDB.putAt(index, newValue);
  }
}
