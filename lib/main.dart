import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'record_repository.dart';
import 'database/database.dart';
import 'footer.dart';
import 'bottom_navigation_bar_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RecordModelAdapter());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return myAwesomeApp();
        }
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return myAwesomeApp();
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return myAwesomeApp();
      },
    );
  }

  myAwesomeApp(){
    return MaterialApp(
      title: 'TubeStack',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiProvider(
          providers: [
            ChangeNotifierProvider<BottomNavigationBarProvider>(
              create: (context) => BottomNavigationBarProvider(),
            ),
            Provider<RecordRepository>(
              create: (context) => RecordRepository(),
            ),
          ],
          child: BottomNavigationBarExample(),
        )
    );
  }
}



