import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/Helper.dart';
import 'package:todo/pages/Home.dart';
import 'package:todo/pages/login.dart';
import 'package:todo/pages/signup.dart';

void main() => runApp(RunApp());

class RunApp extends StatefulWidget {
  const RunApp({super.key});

  @override
  State<RunApp> createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FutureBuilder(
        future: Helper.handel(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return snapshot.data!;
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
