import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';

List<String> list = <String>['Square', 'Circle'];

class QrBoxShape extends StatefulWidget {
  // QrEyeShape eyemodelshape;
  const QrBoxShape({super.key});

  @override
  State<QrBoxShape> createState() => _QrBoxShapeState();
}

class _QrBoxShapeState extends State<QrBoxShape> {
  String eyedropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    QrGeneratorProvider qrGeneratorProvider =
        Provider.of<QrGeneratorProvider>(context, listen: false);
    return Row(
      children: [
        const Text('Box Shape:'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            elevation: 1,
            borderRadius: BorderRadius.circular(10),
            value: eyedropdownValue,
            onChanged: (value) {
              setState(() {});
              eyedropdownValue = value!;

              if (eyedropdownValue == 'Square') {
                // widget.eyemodelshape = QrEyeShape.square;

                qrGeneratorProvider.setEyeShape(QrEyeShape.square);
              } else {
                // widget.eyemodelshape = QrEyeShape.circle;

                qrGeneratorProvider.setEyeShape(QrEyeShape.circle);
              }
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
