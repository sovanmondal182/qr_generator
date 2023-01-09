import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';

class QrBackgroundColor extends StatefulWidget {
  const QrBackgroundColor({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  State<QrBackgroundColor> createState() => _QrBackgroundColorState();
}

class _QrBackgroundColorState extends State<QrBackgroundColor> {
  @override
  Widget build(BuildContext context) {
    QrGeneratorProvider qrGeneratorProvider =
        Provider.of<QrGeneratorProvider>(context, listen: false);
    return Row(
      children: [
        Text(widget.title),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Pick a Color'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        displayThumbColor: true,
                        labelTypes: const [],
                        hexInputBar: true,
                        pickerColor: qrGeneratorProvider.backgroundColor,
                        onColorChanged: (value) {
                          qrGeneratorProvider.setBackdoundColor(value);
                          setState(() {});
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
                // border: Border.all(color: Colors.black),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(1, 2), // changes position of shadow
                  )
                ],
                shape: BoxShape.circle,
                color: qrGeneratorProvider.backgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
