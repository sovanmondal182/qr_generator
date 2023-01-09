import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';

class QrGeneratorResultWithImage extends StatefulWidget {
  const QrGeneratorResultWithImage({
    super.key,
  });

  @override
  State<QrGeneratorResultWithImage> createState() =>
      _QrGeneratorResultWithImageState();
}

class _QrGeneratorResultWithImageState
    extends State<QrGeneratorResultWithImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: Colors.teal,
      body: Consumer<QrGeneratorProvider>(
        builder: (context, qrGeneratorResultWithImage, child) => SafeArea(
          minimum: const EdgeInsets.all(10),
          child: Center(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: QrImage(
              size: 300,
              gapless: qrGeneratorResultWithImage.gapless,
              padding: const EdgeInsets.all(10.0),
              backgroundColor: qrGeneratorResultWithImage.backgroundColor,
              version: 5,
              semanticsLabel: 'QR Code',
              data: qrGeneratorResultWithImage.data!,
              dataModuleStyle: QrDataModuleStyle(
                dataModuleShape: qrGeneratorResultWithImage.dataModuleShape,
                color: qrGeneratorResultWithImage.dataModuleColor,
              ),
              eyeStyle: QrEyeStyle(
                eyeShape: qrGeneratorResultWithImage.eyeShape,
                color: qrGeneratorResultWithImage.eyeColor,
              ),
            ),
          )),
        ),
      ),
    );
  }
}
