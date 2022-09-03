import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encryption_decryption/text_encryption/text_encryption_viewModel.dart';

class DropDownMenu extends ConsumerWidget {
  const DropDownMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(textEncryptionChangeNotifier);
    final read = ref.read(textEncryptionChangeNotifier);

    return DropdownButtonFormField(
      value: watch.currentAlgorithm,
      items: const [
        DropdownMenuItem(value: 'AES', child: Text('AES Algorithm')),
        DropdownMenuItem(value: 'Fernet', child: Text('Fernet Algorithm')),
        DropdownMenuItem(value: 'Salsa20', child: Text('Salsa20 Algorithm')),
      ],
      decoration: const InputDecoration(
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amberAccent, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.amberAccent, width: 3),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      ),
      onChanged: (String? value) {
        read.currentAlgorithm = value;
      },
    );
  }
}
