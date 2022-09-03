import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:encryption_decryption/encrypt.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

final fileEncryptionChangeNotifier = ChangeNotifierProvider<FileEncryptionChangeNotifier>((ref) => FileEncryptionChangeNotifier(),);

class FileEncryptionChangeNotifier extends ChangeNotifier {
  bool _isGranted = true;
  String _fileName = 'demo.mp4';
  final String _videoURL = 'https://assets.mixkit.co/videos/preview/mixkit-clouds-and-blue-sky-2408-large.mp4'; //'https://vk.com/video-96830129_456239071';
  final String _imageURL = 'https://wallup.net/wp-content/uploads/2016/01/245711-nature-landscape-reflection-lake-trees-forest-clouds-field-pine_trees-mountain-snowy_peak-water-calm.jpg';
  final String _pdfURL =  'https://www.irjet.net/archives/V5/i3/IRJET-V5I3124.pdf';
  final String _zipURL =  'https://www.1001freefonts.com/d/4063/admiration-pains.zip';

  Future<Directory?> get getAppDirectory async{
    final appDocDir = await getExternalStorageDirectory();
    return appDocDir;
  }

  Future<Directory> get getExternalVisibleDirectory async{
    if(await Directory('/storage/emulated/0/EncryptionFolder').exists()){
      final externalDir = Directory('/storage/emulated/0/EncryptionFolder');
      return externalDir;
    } else {
      await Directory('/storage/emulated/0/EncryptionFolder').create(recursive: true);
      final externalDir = Directory('/storage/emulated/0/EncryptionFolder');
      return externalDir;
    }
  }

  requestStoragePermission() async{
    if(!await Permission.storage.isGranted){
      PermissionStatus result = await Permission.storage.request();
      if(result.isGranted){
        _isGranted = true;
        notifyListeners();
      } else{
        _isGranted = false;
        notifyListeners();
      }
    }
  }

  Future<void> onEncryption() async{
    if(_isGranted){
      print('Permission is Granted');
      Directory directory = await getExternalVisibleDirectory;
      // Directory hiddenDirectory = await getAppDirectory;
      downloadAndStore(_videoURL, directory, _fileName);
    } else {
      print('Permission is NOT Granted');
      requestStoragePermission();
    }
  }

  Future<void> onDecryption() async{
    if(_isGranted){
      Directory directory = await getExternalVisibleDirectory;
      // Directory hiddenDirectory = await getAppDirectory;
      getNormalFile(directory, _fileName);
    } else {
      requestStoragePermission();
    }
  }

  downloadAndStore(String url, Directory dir, String fileName) async{
    if(await canLaunch(url)){
      print('Downloading ...');
      var response = await http.get(Uri.parse(url));
      var encrypted = encryptData(response.bodyBytes);
      String p = await writeData(encrypted, '${dir.path}/$fileName.aes');
      print('File Encrypted: $p');
    } else{
      print('Invalid URL');
    }
  }

  getNormalFile(Directory dir, String fileName) async{
    Uint8List encryptedData = await readData('${dir.path}/$fileName.aes');
    var plainData = await decryptData(encryptedData);
    String p = await writeData(plainData, '${dir.path}/$fileName');
    print('File decrypted: $p');
  }


  encryptData(plainString) {
    print('Encrypting ...');
    final encrypted = SymmetricEncryption.EncryptFile(plainString);
    return encrypted.bytes;
  }

  decryptData(encryptedData) {
    print('Decrypting ...');
    return SymmetricEncryption.DecryptFile(encryptedData);
  }

  Future<String> writeData(data, path) async{
    print('Writing ...');
    File file = File(path);
    await file.writeAsBytes(data);
    return file.absolute.toString();
  }

  Future<Uint8List> readData(path) async{
    print('Reading ...');
    File file = File(path);
    return await file.readAsBytes();
  }
}