// ignore_for_file: prefer_const_constructors

import 'package:file_manager/controller/add_provider.dart';
import 'package:file_manager/controller/db_provider.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import 'package:provider/provider.dart';
class AddScreen extends StatelessWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Center(
          child: Text(
            'ADD',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => AddScreenProvider(),
        child: _buildUI(context),
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    return Consumer<AddScreenProvider>(
      builder: (context, provider, child) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () async {
                    pickFiless(context);
                  },
                  child: Container(
                    height: 66,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 240, 236, 236),
                      border: Border.all(
                        width: 2,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Center(
                      child: Text(
                        "Add files",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                FloatingActionButton.extended(
                  backgroundColor: Colors.orangeAccent,
                  onPressed: () async {
                    if (provider.selectedFiles != null &&
                        provider.selectedFiles!.isNotEmpty) {
                      await addFileToDb( context, provider.selectedFiles!);

                      // getAlldata(); // Assuming getAlldata is defined somewhere
                      provider.setFiles(null);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          "Added Successfully",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Colors.green,
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Duration(seconds: 1),
                        content: Text(
                          "Select a File",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: const Color.fromARGB(255, 219, 27, 27),
                      ));
                    }
                  },
                  label: Text("Save"),
                ),
                SizedBox(height: 10),
                Divider(),
                if (provider.selectedFiles != null &&
                    provider.selectedFiles!.isNotEmpty)
                  Column(
                    children: [
                      for (int index = 0;
                          index < provider.selectedFiles!.length;
                          index++)
                        GestureDetector(
                          onTap: () {
                            openFile(provider.selectedFiles![index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(208, 255, 147, 7),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Selected File:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      provider.selectedFiles![index].name,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      provider.selectedFiles!.removeAt(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                          border: Border.all(width: 1)),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  void pickFiless(BuildContext context) async {
    AddScreenProvider provider =
        Provider.of<AddScreenProvider>(context, listen: false);

    FilePickerResult? result = await provider.pickFiless();

    if (result != null && result.files.isNotEmpty) {
      provider.setFiles(result.files);
    }
  }

  Future<void> openFile(PlatformFile file) async {
    final filePath = file.path;
    final fileName = file.name;

    try {
      await OpenFile.open(filePath);
      print(fileName);
    } catch (error) {
      print(error);
    }
  }

  Future<void> addFileToDb( BuildContext context, List<PlatformFile> files) async {
    DbProvider dbProvider = Provider.of<DbProvider>(context, listen: false);
    for (var file in files) {
      await dbProvider.pickFile(file);
    }
  }
}
