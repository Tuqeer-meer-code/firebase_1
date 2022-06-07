import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something Went Wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Firebase',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: const MyHomePage(),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
