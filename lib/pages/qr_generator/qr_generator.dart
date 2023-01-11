import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/pages/qr_generator/qr_generator_result.dart';
import 'package:qr_scanner/pages/qr_generator/qr_generator_result_with_image.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';
import 'package:qr_scanner/widgets/qr_generator/qr_image/add_image.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('QR Generator', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your data',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text('Colors'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      QrBackgroundColor(title: 'Background:'),
                      QrBoxColor(title: 'Dot:'),
                      QrDotColor(title: 'Box:'),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  const Text('Shapes'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      QrDotShape(),
                      QrBoxShape(),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  AddImage(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  GestureDetector(
                    onTap: () {
                      qrGeneratorProvider.setData(_textEditingController.text);
                      qrGeneratorProvider.imagePath != ''
                          ? Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const QrGeneratorResultWithImage()))
                          : Navigator.push(
                              (context),
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const QrGeneratorResult()));
                    },
                    child: Container(
                      height: 50,
                      width: 150,
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
                      child: const Center(
                        child: Text('Generate QR'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
