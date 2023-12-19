// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, depend_on_referenced_packages

import 'package:file_manager/controller/audio_provider.dart';
import 'package:file_manager/db/function.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final audioprovider = Provider.of<AudioProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text("audios"),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    const Color.fromARGB(255, 0, 0, 0)),
              ),
              onPressed: () {
                // setState(() {
                  audioprovider.isAscending = false;
                // });
              },
              child: Text("sort")),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                  controller: audioprovider.searchcontroller4,
                  onChanged: audioprovider.onSearchTextchanged,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 240, 236, 236),
                      prefixIcon:
                          Lottie.asset("assets/images/search.json", height: 60),
                      hintText: "search files",
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 151, 146, 146),
                          fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))))),
          Expanded(
            child: ValueListenableBuilder<List<FileModel>>(
              valueListenable: FileNotifier,
              builder: (context, files, child) {
                List<FileModel> sortedFiles = List.from(files);
                sortedFiles.sort((a, b) {
                  return audioprovider.isAscending
                      ? b.fileName.compareTo(a.fileName)
                      : a.fileName.compareTo(b.fileName);
                });
                if (audioprovider.searchQuery.isNotEmpty) {
                  sortedFiles = sortedFiles
                      .where((file) => file.fileName
                          .toLowerCase()
                          .contains(audioprovider.searchQuery.toLowerCase()))
                      .toList();
                }

                return ListView.builder(
                    itemCount: sortedFiles.length,
                    itemBuilder: (context, index) {
                      final file = sortedFiles[index];

                      if (audioprovider. isAudioFile(file.fileName)) {
                        return ListTile(
                          onTap: () {
                            openFile(file);
                          },
                          title: Text(
                            file.fileName,
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          leading: Icon(
                            Icons.audiotrack,
                            color: Colors.orange,
                          ),
                          trailing: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      const Color.fromARGB(255, 255, 255, 255)),
                                  shape: MaterialStatePropertyAll(
                                      CircleBorder(eccentricity: 0))),
                              onPressed: () {
                                _deleteDialog(file,context);
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

  Future<void> _deleteDialog(FileModel file,context) async {
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
