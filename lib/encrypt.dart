import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

class SymmetricEncryption {
  /// AES Algorithm
  static final keyAES = encrypt.Key.fromLength(32);
  static final ivAES = encrypt.IV.fromLength(16);
  static final encrypterAES = encrypt.Encrypter(encrypt.AES(keyAES));

  static String EncryptAES(String text) {
    final encrypted = encrypterAES.encrypt(text, iv: ivAES);

    print('***************** AES *****************');
    print('** BYTES:  ${encrypted.bytes}');
    print('** BASE16: ${encrypted.base16}');
    print('** BASE64: ${encrypted.base64}');
    print('***************************************');

    return encrypted.base64;
  }

  static DecryptAES(String encrypted) {
    // * If encrypted is encrypt.Encrypted
    // final decrypted = encrypterAES.decrypt(encrypted, iv: ivAES);
    // * If encrypted is String
    final decrypted = encrypterAES.decrypt64(encrypted, iv: ivAES);
    return decrypted;
  }

  /// Fernet Algorithm
  static final keyFernet = encrypt.Key.fromUtf8('anyKeyButItMustBe32ByteCharacter');
  static final encrypterFernet = encrypt.Encrypter(encrypt.Fernet(keyFernet));

  static String EncryptFernet(String text) {
    final encrypted = encrypterFernet.encrypt(text);

    print('***************** Fernet *****************');
    print('** BYTES:  ${encrypted.bytes}');
    print('** BASE16: ${encrypted.base16}');
    print('** BASE64: ${encrypted.base64}');
    print('** ${encrypt.Fernet(keyFernet).extractTimestamp(encrypted.bytes)}');
    print('******************************************');

    return encrypted.base64;
  }

  static DecryptFernet(String encrypted) {
    // * If encrypted is encrypt.Encrypted
    // final decrypted = encrypterFernet.decrypt(encrypted);
    // * If encrypted is String
    final decrypted = encrypterFernet.decrypt64(encrypted);
    return decrypted;
  }

  /// Salsa20 Algorithm
  static final keySalsa20 = encrypt.Key.fromLength(32);
  static final ivSalsa20 = encrypt.IV.fromLength(8);
  static final encrypterSalsa20 = encrypt.Encrypter(encrypt.Salsa20(keySalsa20));

  static String EncryptSalsa20(String text) {
    final encrypted = encrypterSalsa20.encrypt(text, iv: ivSalsa20);

    debugPrint('***************** Salsa20 *****************');
    debugPrint('** BYTES:  ${encrypted.bytes}');
    debugPrint('** BASE16: ${encrypted.base16}');
    debugPrint('** BASE64: ${encrypted.base64}');
    debugPrint('*******************************************');

    return encrypted.base64;
  }

  static DecryptSalsa20(String encrypted) {
    // * If encrypted is encrypt.Encrypted
    // final decrypted = encrypterSalsa20.decrypt(encrypted, iv: ivSalsa20);
    // * If encrypted is String
    final decrypted = encrypterSalsa20.decrypt64(encrypted, iv: ivSalsa20);
    return decrypted;
  }







  static final keyFile = encrypt.Key.fromUtf8('anyKeyButItMustBe32ByteCharacter');
  static final ivFile = encrypt.IV.fromUtf8('VivekPanchal1122');
  static final encrypterFile = encrypt.Encrypter(encrypt.AES(keyFile));

  static EncryptFile(plainString) {
    final encrypted = encrypterFile.encryptBytes(plainString, iv: ivFile);
    return encrypted;
  }

  static DecryptFile(encryptedData) {
    final encrypted = encrypt.Encrypted(encryptedData);
    final decrypted = encrypterFile.decryptBytes(encrypted, iv: ivFile);
    return decrypted;
  }
}
