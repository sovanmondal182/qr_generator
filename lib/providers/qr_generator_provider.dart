import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorProvider extends ChangeNotifier {
  File? fileImage;
  String imagePath = '';

  bool gapless;

  Color backgroundColor;

  String? data;

  ImageProvider? embeddedImage;

  double size;

  QrDataModuleShape dataModuleShape;

  Color dataModuleColor;

  QrEyeShape eyeShape;

  Color eyeColor;

  QrGeneratorProvider(
      {this.gapless = false,
      this.backgroundColor = Colors.white,
      this.size = 60,
      this.dataModuleShape = QrDataModuleShape.square,
      this.dataModuleColor = Colors.black,
      this.eyeShape = QrEyeShape.square,
      this.eyeColor = Colors.black});

  setImagePath(String imagePath) {
    this.imagePath = imagePath;
    embeddedImage = FileImage(File(imagePath));
    notifyListeners();
  }

  setGapless(bool gapless) {
    this.gapless = gapless;
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
}
