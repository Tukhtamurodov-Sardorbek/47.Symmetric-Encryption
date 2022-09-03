import 'package:encryption_decryption/file_encryption/viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileEncryptionPage extends ConsumerWidget {
  const FileEncryptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final read = ref.read(fileEncryptionChangeNotifier);
    read.requestStoragePermission();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () => read.onEncryption(),
            child: const Text('Download & Encrypt File'),
          ),
          ElevatedButton(
            onPressed: () => read.onEncryption(),
            child: const Text('Decrypt File'),
          )
        ],
      ),
    );
  }
}
