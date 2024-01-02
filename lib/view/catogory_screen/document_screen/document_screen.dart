// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, depend_on_referenced_packages

import 'package:file_manager/controller/db_provider.dart';
import 'package:file_manager/controller/document_provider.dart';

import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class DocumentScreen extends StatelessWidget {
  const DocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final documentprovider = Provider.of<DocumentProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text(
          "documents",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: documentprovider.searchcontroller5,
              onChanged: documentprovider.onSearchTextChanged,
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
            child: Consumer<DbProvider>(
              builder: (context, dbProvider, child) {
                List<FileModel> filteredFiles = dbProvider.recentFiles
                    .where((file) =>
                        documentprovider.isDocumentFile(file.fileName) &&
                        file.fileName.toLowerCase().contains(
                            documentprovider.searchQuery.toLowerCase()))
                    .toList();

                return ListView.builder(
                    itemCount: filteredFiles.length,
                    itemBuilder: (context, index) {
                      final file = filteredFiles[index];

                      if (documentprovider.isDocumentFile(file.fileName)) {
                        return ListTile(
                          onTap: () {
                            dbProvider.openFile(file);
                          },
                          title: Text(
                            file.fileName,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          leading: Icon(
                            Icons.edit_document,
                            color: Colors.orange,
                          ),
                          trailing: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      const Color.fromARGB(255, 255, 255, 255)),
                                  shape: MaterialStatePropertyAll(
                                      CircleBorder(eccentricity: 0))),
                              onPressed: () {
                                _deleteDialog(file, context, dbProvider);
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        );
                      } else {
                        return Container();
                      }
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteDialog(
      FileModel file, context, DbProvider dbProvider) async {
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
                dbProvider.deleteFile(file);
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
