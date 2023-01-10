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
      appBar: AppBar(
        elevation: 0,
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
                  child: QrImage(
                    size: 300,
                    gapless: qrGeneratorProvider.gapless,
                    padding: const EdgeInsets.all(10.0),
                    backgroundColor: qrGeneratorProvider.backgroundColor,
                    version: 5,
                    semanticsLabel: 'QR Code',
                    data: qrGeneratorProvider.data!,
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
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      qrGeneratorProvider.saveImage();
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
                      child: Center(child: Text('Save')),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      qrGeneratorProvider.shareImage();
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
                      child: Center(child: Text('Share')),
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
}
