// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, depend_on_referenced_packages, library_private_types_in_public_api

import 'package:file_manager/controller/image_provider.dart';
import 'package:file_manager/db/function.dart';
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
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text('Images'),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    const Color.fromARGB(255, 0, 0, 0)),
              ),
              onPressed: () {
                // setState(() {
                imageprovider.isAscending = false;
                // });
              },
              child: Text("sort")),
        ],
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
                      fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<FileModel>>(
              valueListenable: FileNotifier,
              builder: (context, files, child) {
                List<FileModel> sortedFiles = List.from(files);
                sortedFiles.sort((a, b) {
                  return imageprovider.isAscending
                      ? b.fileName.compareTo(a.fileName)
                      : a.fileName.compareTo(b.fileName);
                });

                if (imageprovider.searchQuery.isNotEmpty) {
                  sortedFiles = sortedFiles
                      .where((file) => file.fileName
                          .toLowerCase()
                          .contains(imageprovider.searchQuery.toLowerCase()))
                      .toList();
                }

                return ListView.builder(
                  itemCount: sortedFiles.length,
                  itemBuilder: (context, index) {
                    final file = sortedFiles[index];

                    if (imageprovider.isImageFile(file.fileName)) {
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: ListTile(
                          onTap: () {
                            openFile(file);
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
                              _deleteDialog(file, context);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDialog(FileModel file, context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete ${file.fileName}?',
                    style: TextStyle(fontWeight: FontWeight.bold)),
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
                deleteFile(file);
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
