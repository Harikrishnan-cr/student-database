// ignore_for_file: unused_import





import 'package:database/data_model/data_model.dart';
import 'package:database/screens/home_add_details_screen.dart';

import 'package:database/screens/student_list_screen.dart';
import 'package:database/functions/data_functions.dart';

import 'package:database/screens/fulldeatil.dart';
import 'package:database/screens/update.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main()async{
  
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  if(!Hive.isAdapterRegistered(StudentModelAdapter().typeId)){
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return  MaterialApp(
      home: const AddDetails(),  
      theme: ThemeData(
canvasColor: Colors.blue[100],

      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

