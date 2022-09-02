import 'package:flutter/material.dart';
import 'package:encryption_decryption/encrypt.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController txtController = TextEditingController();
  String? plainText;
  String? currentAlgorithm = 'AES';
  String? encryptedText;
  bool? isEncrypt;

  @override
  Widget build(BuildContext context) {
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
              value: currentAlgorithm,
              items: const [
                DropdownMenuItem(value: 'AES', child: Text('AES Algorithm')),
                DropdownMenuItem(
                    value: 'Fernet', child: Text('Fernet Algorithm')),
                DropdownMenuItem(
                    value: 'Salsa20', child: Text('Salsa20 Algorithm')),
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
                setState(() {
                  currentAlgorithm = value;
                });
              },
            ),
            const SizedBox(height: 24.0),
            TextField(
              controller: txtController,
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
              onChanged: (text){
                setState(() {
                  plainText = txtController.text.trim();
                });
              },
              onSubmitted: (text){
                setState(() {
                  plainText = txtController.text.trim();
                });
              },
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if(plainText != null && plainText!.isNotEmpty){
                      isEncrypt = true;
                      if(currentAlgorithm == 'AES'){
                        encryptedText = SymmetricEncryption.EncryptAES(plainText!);
                      } else if(currentAlgorithm == 'Fernet'){
                        encryptedText = SymmetricEncryption.EncryptFernet(plainText!);
                      } else if(currentAlgorithm == 'Salsa20'){
                        encryptedText = SymmetricEncryption.EncryptSalsa20(plainText!);
                      }
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: plainText != null && plainText!.isNotEmpty
                        ? Colors.amber
                        : Colors.amberAccent.shade100,
                  ),
                  child: Text(
                    'Encrypt',
                    style: TextStyle(
                      color: plainText != null && plainText!.isNotEmpty
                          ? Colors.black
                          : Colors.black45,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (isEncrypt != null && isEncrypt!) {
                      isEncrypt = false;
                      if(currentAlgorithm == 'AES'){
                        encryptedText = SymmetricEncryption.DecryptAES(encryptedText!);
                      } else if(currentAlgorithm == 'Fernet'){
                        encryptedText = SymmetricEncryption.DecryptFernet(encryptedText!);
                      } else if(currentAlgorithm == 'Salsa20'){
                        encryptedText = SymmetricEncryption.DecryptSalsa20(encryptedText!);
                      }
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isEncrypt != null && isEncrypt!
                        ? Colors.amber
                        : Colors.amberAccent.shade100,
                  ),
                  child: Text(
                    'Decrypt',
                    style: TextStyle(
                      color: isEncrypt != null && isEncrypt!
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
                      child: Text(plainText ?? ''),
                    ),
                    const SizedBox(height: 24.0),
                    Text(
                      isEncrypt == null ? 'RESULT TEXT' : isEncrypt != null && isEncrypt! ? 'ENCRYPTED TEXT' : 'DECRYPTED TEXT',
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
                      child: Text(encryptedText ?? ''),
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
