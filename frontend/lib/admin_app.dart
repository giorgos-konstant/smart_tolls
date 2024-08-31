// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_string_interpolations
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:provider/provider.dart';
import 'services/auth.dart';
import 'pages/admin_login.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AdminAuthProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GridFlow Admin',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue.shade500, brightness: Brightness.dark)),
      home: AdminLoginPage(),
    ));
  }
}
