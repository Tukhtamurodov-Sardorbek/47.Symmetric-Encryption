import 'package:flutter/material.dart';
import 'package:encryption_decryption/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
      ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Encryption',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            brightness: Brightness.dark,
          ),
          home: const HomePage(),
        ),
      ),
  );
}