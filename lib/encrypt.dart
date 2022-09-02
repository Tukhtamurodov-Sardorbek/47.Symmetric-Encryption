import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptDecrypt{
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  static EncryptAES(String text){
    final encrypted = encrypter.encrypt(text, iv: iv);

    print('**********************************');
    print('****   BYTES: ${encrypted.bytes}');
    print('****   BASE16: ${encrypted.base16}');
    print('****   BASE64: ${encrypted.base64}');
    print('**********************************');

    return encrypted;
  }

  static DecryptAES(encrypt.Encrypted encrypted){
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
}