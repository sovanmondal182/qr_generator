import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  final GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Consumer<QrGeneratorProvider>(
        builder: (context, qrGeneratorProvider, child) => SafeArea(
          minimum: const EdgeInsets.all(10),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(1, 2), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: RepaintBoundary(
                    key: globalKey,
                    child: QrImage(
                      size: 300,
                      gapless: qrGeneratorProvider.gapless,
                      padding: const EdgeInsets.all(10.0),
                      backgroundColor: qrGeneratorProvider.backgroundColor,
                      version: 5,
                      semanticsLabel: 'QR Code',
                      embeddedImage: qrGeneratorProvider.embeddedImage,
                      data: qrGeneratorProvider.data,
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
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var picData = await _getQrCodeBytes();
                      qrGeneratorProvider.saveImage(picData);
                      FToast().showToast(
                        toastDuration: const Duration(seconds: 2),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.greenAccent,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(Icons.check),
                              SizedBox(
                                width: 12.0,
                              ),
                              Text('Image Saved'),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                1, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue,
                        ),
                      ),
                      child: const Center(child: Text('Save')),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      var picData = await _getQrCodeBytes();
                      qrGeneratorProvider.shareImage(picData);
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                1, 2), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.blue,
                        ),
                      ),
                      child: const Center(child: Text('Share')),
                    ),
                  ),
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  Future<ByteData> _getQrCodeBytes() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage(pixelRatio: 3.413);
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!;
  }
}
