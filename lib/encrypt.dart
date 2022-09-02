import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';

class SymmetricEncryption {
  /// AES Algorithm
  static final keyAES = encrypt.Key.fromLength(32);
  static final ivAES = encrypt.IV.fromLength(16);
  static final encrypterAES = encrypt.Encrypter(encrypt.AES(keyAES));

  static EncryptAES(String text) {
    final encrypted = encrypterAES.encrypt(text, iv: ivAES);

    print('***************** AES *****************');
    print('** BYTES:  ${encrypted.bytes}');
    print('** BASE16: ${encrypted.base16}');
    print('** BASE64: ${encrypted.base64}');
    print('***************************************');

    return encrypted;
  }

  static DecryptAES(encrypt.Encrypted encrypted) {
    final decrypted = encrypterAES.decrypt(encrypted, iv: ivAES);
    return decrypted;
  }

  /// Fernet Algorithm
  static final keyFernet = encrypt.Key.fromUtf8('anyKeyButItMustBe32ByteCharacter');
  static final encrypterFernet = encrypt.Encrypter(encrypt.Fernet(keyFernet));

  static EncryptFernet(String text) {
    final encrypted = encrypterFernet.encrypt(text);

    print('***************** Fernet *****************');
    print('** BYTES:  ${encrypted.bytes}');
    print('** BASE16: ${encrypted.base16}');
    print('** BASE64: ${encrypted.base64}');
    print('** ${encrypt.Fernet(keyFernet).extractTimestamp(encrypted.bytes)}');
    print('******************************************');
    return encrypted;
  }

  static DecryptFernet(encrypt.Encrypted encrypted) {
    final decrypted = encrypterFernet.decrypt(encrypted);
    return decrypted;
  }

  /// Salsa20 Algorithm
  static final keySalsa20 = encrypt.Key.fromLength(32);
  static final ivSalsa20 = encrypt.IV.fromLength(8);
  static final encrypterSalsa20 = encrypt.Encrypter(encrypt.Salsa20(keySalsa20));

  static EncryptSalsa20(String text) {
    final encrypted = encrypterSalsa20.encrypt(text, iv: ivSalsa20);

    debugPrint('***************** Salsa20 *****************');
    debugPrint('** BYTES:  ${encrypted.bytes}');
    debugPrint('** BASE16: ${encrypted.base16}');
    debugPrint('** BASE64: ${encrypted.base64}');
    debugPrint('*******************************************');

    return encrypted;
  }

  static DecryptSalsa20(encrypt.Encrypted encrypted) {
    final decrypted = encrypterSalsa20.decrypt(encrypted, iv: ivSalsa20);
    return decrypted;
  }
}
