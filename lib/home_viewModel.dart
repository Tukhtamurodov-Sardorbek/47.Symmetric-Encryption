import 'package:flutter/material.dart';
import 'package:encryption_decryption/encrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeChangeNotifier = ChangeNotifierProvider<HomeChangeNotifier>(
      (ref) => HomeChangeNotifier(),
);

class HomeChangeNotifier extends ChangeNotifier {
  /// fields
  TextEditingController textController = TextEditingController();
  String? _plainText;
  String? _currentAlgorithm = 'AES';
  String? _encryptedText;
  bool? _isEncrypt;

  /// getters & setters
  String? get plainText => _plainText;
  String? get currentAlgorithm => _currentAlgorithm;
  String? get encryptedText => _encryptedText;
  bool? get isEncrypt => _isEncrypt;
  bool get isEncryptionAvailable => _plainText != null && _plainText!.isNotEmpty;
  bool get isDecryptionAvailable => _isEncrypt != null && _isEncrypt!;

  set currentAlgorithm(String? value){
    if(_currentAlgorithm != value){
      _currentAlgorithm = value;
      notifyListeners();
    }
  }

  /// methods
  String getLabel(){
    return _isEncrypt == null
        ? 'RESULT TEXT'
        : _isEncrypt != null && _isEncrypt!
        ? 'ENCRYPTED TEXT' : 'DECRYPTED TEXT';
  }

  void getInput(){
    _plainText = textController.text.trim();
    notifyListeners();
  }

  void onEncryption(){
    if(_plainText != null && _plainText!.isNotEmpty){
      _isEncrypt = true;
      if(currentAlgorithm == 'AES'){
        _encryptedText = SymmetricEncryption.EncryptAES(_plainText!);
      } else if(currentAlgorithm == 'Fernet'){
        _encryptedText = SymmetricEncryption.EncryptFernet(_plainText!);
      } else if(currentAlgorithm == 'Salsa20'){
        _encryptedText = SymmetricEncryption.EncryptSalsa20(_plainText!);
      }
      notifyListeners();
    }
  }

  void onDecryption(){
    if (_isEncrypt != null && _isEncrypt!) {
      _isEncrypt = false;
      if(currentAlgorithm == 'AES'){
        _encryptedText = SymmetricEncryption.DecryptAES(_encryptedText!);
      } else if(currentAlgorithm == 'Fernet'){
        _encryptedText = SymmetricEncryption.DecryptFernet(_encryptedText!);
      } else if(currentAlgorithm == 'Salsa20'){
        _encryptedText = SymmetricEncryption.DecryptSalsa20(_encryptedText!);
      }
      notifyListeners();
    }
  }
}