import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';

List<String> list = <String>['Square', 'Circle'];

class QrDotShape extends StatefulWidget {
  const QrDotShape({Key? key}) : super(key: key);

  @override
  State<QrDotShape> createState() => _QrDotShapeState();
}

class _QrDotShapeState extends State<QrDotShape> {
  String datadropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    QrGeneratorProvider qrGeneratorProvider =
        Provider.of<QrGeneratorProvider>(context, listen: false);
    return Row(
      children: [
        const Text('Dot Shape:'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            elevation: 1,
            borderRadius: BorderRadius.circular(10),
            value: datadropdownValue,
            onChanged: (value) {
              setState(() {});
              datadropdownValue = value!;

              if (datadropdownValue == 'Square') {
                qrGeneratorProvider
                    .setDataModuleShape(QrDataModuleShape.square);
              } else {
                qrGeneratorProvider
                    .setDataModuleShape(QrDataModuleShape.circle);
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
