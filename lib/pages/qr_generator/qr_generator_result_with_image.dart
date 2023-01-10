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
      body: Consumer<QrGeneratorProvider>(
        builder: (context, qrGeneratorProvider, child) => SafeArea(
          minimum: const EdgeInsets.all(10),
          child: Center(
              child: Column(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: QrImage(
                    size: 300,
                    gapless: qrGeneratorProvider.gapless,
                    padding: const EdgeInsets.all(10.0),
                    backgroundColor: qrGeneratorProvider.backgroundColor,
                    version: 5,
                    semanticsLabel: 'QR Code',
                    embeddedImage: qrGeneratorProvider.embeddedImage,
                    data: qrGeneratorProvider.data!,
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: Size(
                          qrGeneratorProvider.size, qrGeneratorProvider.size),
                      color: Colors.transparent,
                    ),
                    dataModuleStyle: QrDataModuleStyle(
                      dataModuleShape: qrGeneratorProvider.dataModuleShape,
                      color: qrGeneratorProvider.dataModuleColor,
                    ),
                    eyeStyle: QrEyeStyle(
                      eyeShape: qrGeneratorProvider.eyeShape,
                      color: qrGeneratorProvider.eyeColor,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Text('Save'),
                  ),
                  Container(
                    child: Text('Share'),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }
}
