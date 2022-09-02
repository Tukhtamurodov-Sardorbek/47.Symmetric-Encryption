import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptDecrypt{
  
  /// AES Algorithm
  static final keyAES = encrypt.Key.fromLength(32);
  static final ivAES = encrypt.IV.fromLength(16);
  static final encrypterAES = encrypt.Encrypter(encrypt.AES(keyAES));

  static EncryptAES(String text){
    final encrypted = encrypterAES.encrypt(text, iv: ivAES);

    print('**********************************');
    print('****   BYTES: ${encrypted.bytes}');
    print('****   BASE16: ${encrypted.base16}');
    print('****   BASE64: ${encrypted.base64}');
    print('**********************************');

    return encrypted;
  }
  static DecryptAES(encrypt.Encrypted encrypted){
    final decrypted = encrypterAES.decrypt(encrypted, iv: ivAES);
    return decrypted;
  }

  /// Fernet Algorithm
  static final keyFernet = encrypt.Key.fromUtf8('anyKeyButItMustBe32ByteCharacter');
  static final encrypterFernet = encrypt.Encrypter(encrypt.Fernet(keyFernet));

  static EncryptFernet(String text){
    final encrypted = encrypterFernet.encrypt(text);

    print('**********************************');
    print('****   BYTES: ${encrypted.bytes}');
    print('****   BASE16: ${encrypted.base16}');
    print('****   BASE64: ${encrypted.base64}');
    print('**********************************');

    return encrypted;
  }
  static DecryptFernet(encrypt.Encrypted encrypted){
    final decrypted = encrypterFernet.decrypt(encrypted);
    return decrypted;
  }
}