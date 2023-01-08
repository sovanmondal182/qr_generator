import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/pages/qr_generator/qr_generator_result.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';

class QrGenerator extends StatefulWidget {
  QrGenerator({Key? key}) : super(key: key);

  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

List<String> list = <String>['Square', 'Circle'];

class _QrGeneratorState extends State<QrGenerator> {
  final _textEditingController = TextEditingController();
  ValueNotifier<bool> gapless = ValueNotifier<bool>(false);
  ValueNotifier<Color> backgroundColor = ValueNotifier<Color>(Colors.white);
  ValueNotifier<Color> datamoduleColor = ValueNotifier<Color>(Colors.black);
  ValueNotifier<Color> eyeColor = ValueNotifier<Color>(Colors.black);
  ValueNotifier<double> size = ValueNotifier<double>(1.0);
  String datadropdownValue = list.first;
  ValueNotifier<QrDataModuleShape> dataModuleShape =
      ValueNotifier<QrDataModuleShape>(QrDataModuleShape.square);
  String eyedropdownValue = list.first;
  ValueNotifier<QrEyeShape> eyemodelshape =
      ValueNotifier<QrEyeShape>(QrEyeShape.square);
  // ValueNotifier<ImageProvider> embeddedImage =
  //     ValueNotifier<ImageProvider>(const AssetImage('images/codesta.png'));

  @override
  Widget build(BuildContext context) {
    QrGeneratorProvider qrGeneratorProvider =
        Provider.of<QrGeneratorProvider>(context, listen: false);
    return Scaffold(
      // backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text('QR Generator'),
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your data',
                  ),
                  onSubmitted: (value) {},
                ),
                Row(
                  children: [
                    Text('Gapless:'),
                    ValueListenableBuilder(
                      valueListenable: gapless,
                      builder: (context, value, child) => Switch(
                          value: value,
                          onChanged: (value) {
                            gapless.value = value;
                          }),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Background Color:'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder(
                        valueListenable: backgroundColor,
                        builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Pick a Color'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      hexInputBar: true,
                                      displayThumbColor: true,
                                      colorPickerWidth: 300,
                                      pickerColor: backgroundColor.value,
                                      onColorChanged: ((value) {
                                        backgroundColor.value = value;
                                      }),
                                      pickerAreaHeightPercent: 0.8,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.circle,
                              color: backgroundColor.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Dot color:'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder(
                        valueListenable: datamoduleColor,
                        builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Pick a Color'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: datamoduleColor.value,
                                      onColorChanged: (value) {
                                        datamoduleColor.value = value;
                                      },
                                      pickerAreaHeightPercent: 0.8,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: datamoduleColor.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Box Color:'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder(
                        valueListenable: eyeColor,
                        builder: (context, value, child) => GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Pick a Color'),
                                  content: SingleChildScrollView(
                                    child: ColorPicker(
                                      pickerColor: eyeColor.value,
                                      onColorChanged: (value) {
                                        eyeColor.value = value;
                                      },
                                      pickerAreaHeightPercent: 0.8,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('Ok'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: eyeColor.value,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Image Size:'),
                    ValueListenableBuilder(
                      valueListenable: size,
                      builder: (context, value, child) => Slider(
                        value: size.value,
                        onChanged: (value) {
                          size.value = value;
                        },
                        min: 1,
                        max: 60,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Dot Shape:'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder(
                        valueListenable: dataModuleShape,
                        builder: (context, value, child) =>
                            DropdownButton<String>(
                          value: datadropdownValue,
                          onChanged: (value) {
                            datadropdownValue = value!;

                            dataModuleShape.value =
                                datadropdownValue == 'Square'
                                    ? QrDataModuleShape.square
                                    : QrDataModuleShape.circle;
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Box Shape:'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ValueListenableBuilder(
                        valueListenable: eyemodelshape,
                        builder: (context, value, child) =>
                            DropdownButton<String>(
                          value: eyedropdownValue,
                          onChanged: (value) {
                            eyedropdownValue = value!;

                            eyemodelshape.value = eyedropdownValue == 'Square'
                                ? QrEyeShape.square
                                : QrEyeShape.circle;
                          },
                          items: list
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      qrGeneratorProvider.setData(
                        gapless.value,
                        backgroundColor.value,
                        _textEditingController.text,
                        AssetImage('images/codesta.png'),
                        size.value,
                        dataModuleShape.value,
                        datamoduleColor.value,
                        eyemodelshape.value,
                        eyeColor.value,
                      );
                      Navigator.push(
                          (context),
                          MaterialPageRoute(
                              builder: (context) => QrGeneratorResult()));
                    },
                    child: Text('Generate QR')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
