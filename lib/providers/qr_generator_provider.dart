import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QrGeneratorProvider extends ChangeNotifier {
  String imagePath = '';

  bool gapless = true;

  Color backgroundColor;

  String data = '';

  ImageProvider? embeddedImage;

  double size;

  QrDataModuleShape dataModuleShape;

  Color dataModuleColor;

  QrEyeShape eyeShape;

  Color eyeColor;

  QrGeneratorProvider(
      {this.backgroundColor = Colors.white,
      this.size = 50,
      this.dataModuleShape = QrDataModuleShape.square,
      this.dataModuleColor = Colors.black,
      this.eyeShape = QrEyeShape.square,
      this.eyeColor = Colors.black});

  setImagePath(String imagePath) {
    this.imagePath = imagePath;
    embeddedImage = FileImage(File(imagePath));
    notifyListeners();
  }

  setBackdoundColor(Color backgroundColor) {
    this.backgroundColor = backgroundColor;
    notifyListeners();
  }

  setData(String data) {
    this.data = data;
    notifyListeners();
  }

  setSize(double size) {
    this.size = size;
    notifyListeners();
  }

  setDataModuleShape(QrDataModuleShape dataModuleShape) {
    this.dataModuleShape = dataModuleShape;
    notifyListeners();
  }

  setDataModuleColor(Color dataModuleColor) {
    this.dataModuleColor = dataModuleColor;
    notifyListeners();
  }

  setEyeShape(QrEyeShape eyeShape) {
    this.eyeShape = eyeShape;
    notifyListeners();
  }

  setEyeColor(Color eyeColor) {
    this.eyeColor = eyeColor;
    notifyListeners();
  }

  saveImage(ByteData picData) async {
    String path = await getPath();
    await writeToFile(picData, path);

    await GallerySaver.saveImage(path);

    notifyListeners();
  }

  shareImage(ByteData picData) async {
    String path = await getPath();
    await writeToFile(picData, path);

    await Share.shareXFiles(
      [XFile(path)],
    );
    notifyListeners();
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  Future<String> getPath() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.png';

    return path;
  }
}
