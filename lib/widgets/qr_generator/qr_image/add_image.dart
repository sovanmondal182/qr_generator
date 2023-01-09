import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';

class AddImage extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  String? imagePath;
  final ImagePicker _picker = ImagePicker();
  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);
    if (pickedFile == null) return;
    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) return;
    await compressImage(file.path, 35);
  }

  Future<File> compressImage(String path, int quality) async {
    QrGeneratorProvider qrGeneratorProvider =
        Provider.of<QrGeneratorProvider>(context, listen: false);
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);
    imagePath = result!.path;
    setState(() {});
    qrGeneratorProvider.setImagePath(result.path);

    return result;
  }

  bool addImage = false;
  double size = 1.0;

  @override
  Widget build(BuildContext context) {
    QrGeneratorProvider qrGeneratorProvider =
        Provider.of<QrGeneratorProvider>(context, listen: false);

    return Column(
      children: [
        Row(
          children: [
            const Text('Add Image:'),
            Switch(
                value: addImage,
                onChanged: (value) {
                  setState(() {});
                  addImage = value;
                }),
          ],
        ),
        addImage == true
            ? Column(
                children: [
                  Row(children: [
                    const Text('Image:'),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => BottomSheet(
                                  builder: (context) => Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ListTile(
                                        leading: const Icon(Icons.camera),
                                        title: const Text('Camera'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _pickImage(ImageSource.camera);
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.image),
                                        title: const Text('Gallery'),
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          _pickImage(ImageSource.gallery);
                                        },
                                      ),
                                    ],
                                  ),
                                  onClosing: () {},
                                ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: qrGeneratorProvider.imagePath == ''
                            ? Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey)),
                                child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: const [
                                        Icon(Icons.image),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text('Browse'),
                                      ],
                                    )))
                            : Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.file(
                                      File(qrGeneratorProvider.imagePath),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                      qrGeneratorProvider.setImagePath('');
                                    },
                                    child: const Icon(Icons.close),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ]),
                  Row(
                    children: [
                      const Text('Image Size:'),
                      qrGeneratorProvider.imagePath != ''
                          ? Slider(
                              activeColor: Colors.teal,
                              value: size,
                              onChanged: (value) {
                                setState(() {});
                                size = value;
                                qrGeneratorProvider.setSize(size);
                              },
                              min: 1,
                              max: 60,
                            )
                          : Slider(
                              min: 1, max: 60, value: size, onChanged: null),
                    ],
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
