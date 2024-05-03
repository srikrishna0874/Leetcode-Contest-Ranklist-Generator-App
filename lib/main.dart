import 'package:flutter/material.dart';
import 'package:leetcode_ranklist_generator/screens/home.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(255, 161, 22, 1),
      ),
      home: MyHomePage(),
    );
  }
}
