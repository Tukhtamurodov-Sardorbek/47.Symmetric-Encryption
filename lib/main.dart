import 'package:flutter/material.dart';
import 'package:encryption_decryption/home_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encryption_decryption/widgets/scroll_config.dart';

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

          // * To remove the glow on the whole application
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: child!,
            );
          },
        ),
      ),
  );
}