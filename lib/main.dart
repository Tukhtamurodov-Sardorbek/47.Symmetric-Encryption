import 'package:encryption_decryption/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Encryption Decryption',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController txtController = TextEditingController();
  var plainText;
  var encryptedText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Encryption ~ Decryption'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: txtController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amberAccent, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  'PLAIN TEXT',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.amber[400],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(plainText ?? ''),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'ENCRYPTED TEXT',
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.amber[400],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(encryptedText == null
                      ? ''
                      : encryptedText is encrypt.Encrypted
                          ? encryptedText.base64
                          : encryptedText),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    plainText = txtController.text.trim();
                    setState(() {
                      encryptedText = EncryptDecrypt.EncryptAES(plainText);
                    });
                  },
                  child: const Text('Encrypt'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (encryptedText is encrypt.Encrypted) {
                      setState(() {
                        encryptedText =
                            EncryptDecrypt.DecryptAES(encryptedText);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: encryptedText is encrypt.Encrypted
                        ? Colors.amber
                        : Colors.amberAccent.shade100,
                  ),
                  child: Text(
                    'Decrypt',
                    style: TextStyle(
                      color: encryptedText is encrypt.Encrypted
                          ? Colors.black
                          : Colors.black45,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
