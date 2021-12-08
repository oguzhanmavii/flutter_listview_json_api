import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listview_json_api_app/screens/home_page.dart';

void main() => runApp(const MyJsonApp());

class MyJsonApp extends StatelessWidget {
  const MyJsonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(
        title: '',
      ),
    );
  }
}
