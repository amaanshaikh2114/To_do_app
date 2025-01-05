import 'package:flutter/material.dart';
import 'package:todo_app/tasks.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Tasks(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
