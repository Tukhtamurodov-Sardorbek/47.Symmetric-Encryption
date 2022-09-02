import 'package:flutter/material.dart';
import 'package:encryption_decryption/home_viewModel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(homeChangeNotifier);
    final read = ref.read(homeChangeNotifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Encryption ~ Decryption'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            DropdownButtonFormField(
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
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: watch.textController,
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
              onChanged: (text) {
                read.getInput();
              },
              onSubmitted: (text) {
                read.getInput();
              },
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    read.onEncryption();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: watch.isEncryptionAvailable
                        ? Colors.amber
                        : Colors.amberAccent.shade100,
                  ),
                  child: Text(
                    'Encrypt',
                    style: TextStyle(
                      color: watch.isEncryptionAvailable
                          ? Colors.black
                          : Colors.black45,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    read.onDecryption();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: watch.isEncryptionAvailable
                        ? Colors.amber
                        : Colors.amberAccent.shade100,
                  ),
                  child: Text(
                    'Decrypt',
                    style: TextStyle(
                      color: watch.isEncryptionAvailable
                          ? Colors.black
                          : Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'PLAIN TEXT',
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.amber[400],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amberAccent, width: 3),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Text(watch.plainText ?? ''),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      read.getLabel(),
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.amber[400],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.amberAccent, width: 3),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(12.0)),
                      ),
                      child: Text(watch.encryptedText ?? ''),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

