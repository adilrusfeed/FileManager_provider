// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, depend_on_referenced_packages, library_private_types_in_public_api

import 'package:file_manager/controller/db_provider.dart';
import 'package:file_manager/controller/image_provider.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ImageScreen extends StatelessWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageprovider = Provider.of<ImagesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text(
          'Images',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: imageprovider.searchcontroller2,
              onChanged: imageprovider.onSearchTextChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 240, 236, 236),
                prefixIcon:
                    Lottie.asset("assets/images/search.json", height: 60),
                hintText: 'Search Files',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 151, 146, 146),
                  fontWeight: FontWeight.w500,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Expanded(
            child: Consumer<DbProvider>(
              builder: (context, dbprovider, child) {
                List<FileModel> filteredFiles = dbprovider.recentFiles
                    .where((file) =>
                        imageprovider.isImageFile(file.fileName) &&
                        file.fileName
                            .toLowerCase()
                            .contains(imageprovider.searchQuery.toLowerCase()))
                    .toList();

                return ListView.builder(
                  itemCount: filteredFiles.length,
                  itemBuilder: (context, index) {
                    final file = filteredFiles[index];

                    return Padding(
                      padding: const EdgeInsets.all(3),
                      child: ListTile(
                        onTap: () {
                          dbprovider.openFile(file);
                        },
                        title: Text(file.fileName),
                        leading: Icon(
                          Icons.image,
                          color: Colors.orange,
                        ),
                        trailing: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              const Color.fromARGB(255, 255, 255, 255),
                            ),
                            shape: MaterialStatePropertyAll(
                              CircleBorder(eccentricity: 0),
                            ),
                          ),
                          onPressed: () {
                            _deleteDialog(file, context, dbprovider);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDialog(
      FileModel file, context, DbProvider dbprovider) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to delete ${file.fileName}?',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                dbprovider.deleteFile(file);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
