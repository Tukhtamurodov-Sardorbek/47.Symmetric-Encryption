import 'package:flutter/material.dart';
import 'package:encryption_decryption/home.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Encryption Decryption',
    theme: ThemeData(
      primarySwatch: Colors.amber,
      brightness: Brightness.dark,
    ),
    home: const HomePage(),
  ));
}
