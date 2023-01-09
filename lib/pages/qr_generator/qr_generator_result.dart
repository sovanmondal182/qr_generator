import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';

class QrGeneratorResult extends StatefulWidget {
  const QrGeneratorResult({
    super.key,
  });

  @override
  State<QrGeneratorResult> createState() => _QrGeneratorResultState();
}

class _QrGeneratorResultState extends State<QrGeneratorResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Consumer<QrGeneratorProvider>(
        builder: (context, qrGeneratorResult, child) => SafeArea(
          minimum: const EdgeInsets.all(10),
          child: Center(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: QrImage(
              size: 300,
              gapless: qrGeneratorResult.gapless,
              padding: const EdgeInsets.all(10.0),
              backgroundColor: qrGeneratorResult.backgroundColor,
              version: 5,
              semanticsLabel: 'QR Code',
              embeddedImage: qrGeneratorResult.embeddedImage,
              data: qrGeneratorResult.data!,
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(qrGeneratorResult.size, qrGeneratorResult.size),
                color: Colors.transparent,
              ),
              dataModuleStyle: QrDataModuleStyle(
                dataModuleShape: qrGeneratorResult.dataModuleShape,
                color: qrGeneratorResult.dataModuleColor,
              ),
              eyeStyle: QrEyeStyle(
                eyeShape: qrGeneratorResult.eyeShape,
                color: qrGeneratorResult.eyeColor,
              ),
            ),
          )),
        ),
      ),
    );
  }
}
