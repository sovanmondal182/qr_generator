import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrGeneratorProvider extends ChangeNotifier {
  bool gapless;

  Color backgroundColor;

  String data;

  ImageProvider embeddedImage;

  double size;

  QrDataModuleShape dataModuleShape;

  Color dataModuleColor;

  QrEyeShape eyeShape;

  Color eyeColor;

  QrGeneratorProvider(
      {this.gapless = false,
      this.backgroundColor = Colors.white,
      this.data = '',
      this.embeddedImage = const AssetImage('images/codesta.png'),
      this.size = 60,
      this.dataModuleShape = QrDataModuleShape.square,
      this.dataModuleColor = Colors.black,
      this.eyeShape = QrEyeShape.square,
      this.eyeColor = Colors.black});

  setData(
      bool gapless,
      Color backgroundColor,
      String data,
      ImageProvider embeddedImage,
      double size,
      QrDataModuleShape dataModuleShape,
      Color dataModuleColor,
      QrEyeShape eyeShape,
      Color eyeColor) {
    this.gapless = gapless;
    this.backgroundColor = backgroundColor;
    this.data = data;
    this.embeddedImage = embeddedImage;
    this.size = size;
    this.dataModuleShape = dataModuleShape;
    this.dataModuleColor = dataModuleColor;
    this.eyeShape = eyeShape;
    this.eyeColor = eyeColor;
    notifyListeners();
  }
}
