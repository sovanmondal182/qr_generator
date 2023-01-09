import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/qr_generator/qr_generator_result.dart';
import 'package:qr_scanner/pages/qr_generator/qr_generator_result_with_image.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';
import 'package:qr_scanner/widgets/qr_generator/qr_image/add_image.dart';
import 'package:qr_scanner/widgets/qr_generator/gap_less.dart';
import 'package:qr_scanner/widgets/qr_generator/qr_box/qr_box_color.dart';
import 'package:qr_scanner/widgets/qr_generator/qr_box/qr_box_shape.dart';
import 'package:qr_scanner/widgets/qr_generator/qr_data/qr_dot_color.dart';
import 'package:qr_scanner/widgets/qr_generator/qr_data/qr_dot_shape.dart';
import 'package:qr_scanner/widgets/qr_generator/qr_background_color.dart';

class QrGenerator extends StatefulWidget {
  const QrGenerator({Key? key}) : super(key: key);

  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  final _textEditingController = TextEditingController();
  Color backgroundColor = Colors.white;
  Color datamoduleColor = Colors.black;
  Color eyeColor = Colors.black;
  late PermissionStatus _permissionStatus;
  // QrDataModuleShape dataModuleShape = QrDataModuleShape.square;
  // QrEyeShape eyemodelshape = QrEyeShape.square;
  Directory? tempDir;
  // <ImageProvider> embeddedImage =
  //     <ImageProvider>(AssetImage(imagePath));
  // File file = File(File.imagePath);
  // ImageProvider? embeddedImage = AssetImage(imagePath);
// FileImage? fileImage=FileImage(File(file.imagePath));

  // void _requestTempDirectory() {
  //   setState(() {
  //     tempDir = getTemporaryDirectory() as Directory?;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    () async {
      _permissionStatus = await Permission.storage.status;

      if (_permissionStatus != PermissionStatus.granted) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        setState(() {
          _permissionStatus = permissionStatus;
        });
      }
    }();
    // _requestTempDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text('QR Generator'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Consumer<QrGeneratorProvider>(
          builder: (context, qrGeneratorProvider, child) =>
              SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your data',
                    ),
                  ),
                  const GapLess(),
                  const QrBackgroundColor(title: 'Background Color:'),
                  const QrBoxColor(title: 'Dot color:'),
                  const QrDotColor(title: 'Box Color:'),
                  const QrDotShape(),
                  const QrBoxShape(),
                  AddImage(),
                  ElevatedButton(
                      onPressed: () {
                        qrGeneratorProvider
                            .setData(_textEditingController.text);
                        qrGeneratorProvider.imagePath != ''
                            ? Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const QrGeneratorResult()))
                            : Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const QrGeneratorResultWithImage()));
                      },
                      child: const Text('Generate QR')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
