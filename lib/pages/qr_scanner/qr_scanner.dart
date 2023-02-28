import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart' as mobile_scanner;
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/pages/qr_scanner/qr_scanner_result.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';
import 'package:scan/scan.dart';
// import 'package:camera/camera.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  mobile_scanner.MobileScannerController cameraController =
      mobile_scanner.MobileScannerController();
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    QrGeneratorProvider qrGeneratorProvider =
        Provider.of<QrGeneratorProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Mobile Scanner'),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as mobile_scanner.TorchState) {
                    case mobile_scanner.TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case mobile_scanner.TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as mobile_scanner.CameraFacing) {
                    case mobile_scanner.CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case mobile_scanner.CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => cameraController.switchCamera(),
            ),
            IconButton(
              color: Colors.white,
              icon: const Icon(Icons.image),
              iconSize: 32.0,
              onPressed: () async {
                try {
                  // cameraController.start();
                  final ImagePicker picker = ImagePicker();

                  final pickedFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile == null) return;

                  final image = await Scan.parse(pickedFile.path);
                  // final image =
                  //     await cameraController.analyzeImage(pickedFile.path);
                  print(image);
                  print('image' + image.toString());
                  // ignore: use_build_context_synchronously
                  if (image != "") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return QrScannerResult(qrCode: image!);
                    }));
                  } else {
                    FToast().showToast(
                      toastDuration: const Duration(seconds: 2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          // color: Colors.greenAccent,
                        ),
                        child: Text('No Data Found!'),
                      ),
                    );
                  }
                } on PlatformException catch (err) {
                  print(err);
                } catch (e) {
                  print(e);
                }
              },
              // },
            ),
          ],
        ),
        body: Stack(
          children: [
            mobile_scanner.MobileScanner(
                fit: BoxFit.contain,
                allowDuplicates: false,
                controller: cameraController,
                onDetect: (barcode, args) {
                  if (barcode.rawValue == null) {
                    debugPrint('Failed to scan Barcode');
                  } else {
                    final String code = barcode.rawValue!;
                    debugPrint('Barcode found! $code');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return QrScannerResult(qrCode: code);
                    }));
                  }
                }),
            // QRView(
            //   key: qrKey,
            //   onQRViewCreated: ((p0) {}),
            //   overlay: QrScannerOverlayShape(
            //     borderColor: Colors.red,
            //     borderRadius: 10,
            //     borderLength: 30,
            //     borderWidth: 10,
            //     cutOutSize: 300,
            //   ),
            // overlayMargin: EdgeInsets.all(20),
            // ),

            //           void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
            //   final width = rect.width;
            //   final borderWidthSize = width / 2;
            //   final height = rect.height;
            //   final borderOffset = borderWidth / 2;
            //   final _borderLength =
            //       borderLength > min(cutOutHeight, cutOutHeight) / 2 + borderWidth * 2
            //           ? borderWidthSize / 2
            //           : borderLength;
            //   final _cutOutWidth =
            //       cutOutWidth < width ? cutOutWidth : width - borderOffset;
            //   final _cutOutHeight =
            //       cutOutHeight < height ? cutOutHeight : height - borderOffset;

            //   final backgroundPaint = Paint()
            //     ..color = overlayColor
            //     ..style = PaintingStyle.fill;

            //   final borderPaint = Paint()
            //     ..color = borderColor
            //     ..style = PaintingStyle.stroke
            //     ..strokeWidth = borderWidth;

            //   final boxPaint = Paint()
            //     ..color = borderColor
            //     ..style = PaintingStyle.fill
            //     ..blendMode = BlendMode.dstOut;

            //   final cutOutRect = Rect.fromLTWH(
            //     rect.left + width / 2 - _cutOutWidth / 2 + borderOffset,
            //     -cutOutBottomOffset +
            //         rect.top +
            //         height / 2 -
            //         _cutOutHeight / 2 +
            //         borderOffset,
            //     _cutOutWidth - borderOffset * 2,
            //     _cutOutHeight - borderOffset * 2,
            //   );

            //   canvas
            //     ..saveLayer(
            //       rect,
            //       backgroundPaint,
            //     )
            //     ..drawRect(
            //       rect,
            //       backgroundPaint,
            //     )
            //     // Draw top right corner
            //     ..drawRRect(
            //       RRect.fromLTRBAndCorners(
            //         cutOutRect.right - _borderLength,
            //         cutOutRect.top,
            //         cutOutRect.right,
            //         cutOutRect.top + _borderLength,
            //         topRight: Radius.circular(borderRadius),
            //       ),
            //       borderPaint,
            //     )
            //     // Draw top left corner
            //     ..drawRRect(
            //       RRect.fromLTRBAndCorners(
            //         cutOutRect.left,
            //         cutOutRect.top,
            //         cutOutRect.left + _borderLength,
            //         cutOutRect.top + _borderLength,
            //         topLeft: Radius.circular(borderRadius),
            //       ),
            //       borderPaint,
            //     )
            //     // Draw bottom right corner
            //     ..drawRRect(
            //       RRect.fromLTRBAndCorners(
            //         cutOutRect.right - _borderLength,
            //         cutOutRect.bottom - _borderLength,
            //         cutOutRect.right,
            //         cutOutRect.bottom,
            //         bottomRight: Radius.circular(borderRadius),
            //       ),
            //       borderPaint,
            //     )
            //     // Draw bottom left corner
            //     ..drawRRect(
            //       RRect.fromLTRBAndCorners(
            //         cutOutRect.left,
            //         cutOutRect.bottom - _borderLength,
            //         cutOutRect.left + _borderLength,
            //         cutOutRect.bottom,
            //         bottomLeft: Radius.circular(borderRadius),
            //       ),
            //       borderPaint,
            //     )
            //     ..drawRRect(
            //       RRect.fromRectAndRadius(
            //         cutOutRect,
            //         Radius.circular(borderRadius),
            //       ),
            //       boxPaint,
            //     )
            //     ..restore();
            // }
          ],
        ));
  }
}
