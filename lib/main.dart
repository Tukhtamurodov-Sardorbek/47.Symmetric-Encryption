import 'package:encryption_decryption/scroll_config.dart';
import 'package:flutter/material.dart';
import 'package:encryption_decryption/text_encryption/text_encryption_view.dart';
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
          home: const TextEncryptionPage(),

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