import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class QrGeneratorProvider extends ChangeNotifier {
  File? fileImage;
  String path = '';
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

  saveImage() async {
    final qrValidationResult = QrValidator.validate(
      data: data!,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    if (qrValidationResult.status == QrValidationStatus.valid) {
      final qrCode = qrValidationResult.qrCode;
    } else {
      qrValidationResult.error;
    }
    final qrCode = qrValidationResult.qrCode;

    final painter = QrPainter.withQr(
      qr: qrCode!,
      color: const Color(0xFF000000),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    final ts = DateTime.now().millisecondsSinceEpoch.toString();
    String path = '$tempPath/$ts.png';
    final picData =
        await painter.toImageData(2048, format: ui.ImageByteFormat.png);
    this.path = path;
    await writeToFile(picData!, path);

    await GallerySaver.saveImage(path);

    notifyListeners();
  }

  shareImage() async {
    // final path = imagePath;
    await Share.shareXFiles([XFile(path)],
        // mimeTypes: ["image/png"],
        subject: 'My QR code',
        text: 'Please scan me');
    print('send');
  }

  Future<void> writeToFile(ByteData data, String path) async {
    final buffer = data.buffer;
    await File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
