import 'package:flutter/material.dart';
import 'user_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employees Detail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserListPage(),
    );
  }
}
