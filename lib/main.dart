// ignore_for_file: prefer_const_constructors, unnecessary_import

//
import 'package:file_manager/controller/add_provider.dart';
import 'package:file_manager/controller/audio_provider.dart';
import 'package:file_manager/controller/bottom_provider.dart';
import 'package:file_manager/controller/chart_provider.dart';
import 'package:file_manager/controller/document_provider.dart';
import 'package:file_manager/controller/image_provider.dart';
import 'package:file_manager/controller/recent_screen_provider.dart';
import 'package:file_manager/controller/video_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:file_manager/widgets/bottombar.dart';
import 'package:file_manager/model/data_model.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter<FileModel>(FileModelAdapter());
  await Hive.openBox<FileModel>("FileModel_db");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RecentScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FileManagerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DocumentProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AudioProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChartScreenProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => VideoProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'File organiser',
        debugShowCheckedModeBanner: false,
        home: BottomBar(),
      ),
    );
  }
}
