// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, avoid_unnecessary_containers

import 'package:file_manager/controller/db_provider.dart';
import 'package:file_manager/controller/video_provider.dart';

import 'package:file_manager/model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

class VideoScreen extends StatelessWidget {
  const VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final videoprovider = Provider.of<VideoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: Text("videos"),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    const Color.fromARGB(255, 0, 0, 0)),
              ),
              onPressed: () {
                // setState(() {
                  videoprovider.isAscending = false;
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
              controller: videoprovider.searchController3,
              onChanged:videoprovider. onSearchTextChanged,
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
                List<FileModel> sortedFiles = List.from(dbProvider.recentFiles);
                sortedFiles.sort((a, b) {
                  return videoprovider.isAscending
                      ? b.fileName.compareTo(a.fileName)
                      : a.fileName.compareTo(b.fileName);
                });

                if (videoprovider.searchQuery.isNotEmpty) {
                  sortedFiles = sortedFiles
                      .where((file) => file.fileName
                          .toLowerCase()
                          .contains(videoprovider.searchQuery.toLowerCase()))
                      .toList();
                }

                return ListView.builder(
                    itemCount: sortedFiles.length,
                    itemBuilder: (context, index) {
                      final file = sortedFiles[index];

                      if (videoprovider.isVideoFile(file.fileName)) {
                        return Padding(
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            child: ListTile(
                              onTap: () {
                               dbProvider. openFile(file);
                              },
                              title: Text(
                                file.fileName,
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              leading: Icon(
                                Icons.video_camera_back_outlined,
                                color: Colors.orange,
                              ),
                              trailing: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          const Color.fromARGB(
                                              255, 255, 255, 255)),
                                      shape: MaterialStatePropertyAll(
                                          CircleBorder(eccentricity: 0))),
                                  onPressed: () {
                                    _deleteDialog(file,context,dbProvider);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                          ),
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

  Future<void> _deleteDialog(FileModel file,context,DbProvider dbProvider) async {
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
              dbProvider.  deleteFile(file);
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
