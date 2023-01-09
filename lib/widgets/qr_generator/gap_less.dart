import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/providers/qr_generator_provider.dart';

class GapLess extends StatefulWidget {
  const GapLess({super.key});

  @override
  State<GapLess> createState() => _GapLessState();
}

class _GapLessState extends State<GapLess> {
  bool gapless = false;

  @override
  Widget build(BuildContext context) {
    QrGeneratorProvider qrGeneratorProvider =
        Provider.of<QrGeneratorProvider>(context, listen: false);
    return Row(
      children: [
        const Text('Gapless:'),
        Switch(
            value: gapless,
            onChanged: (value) {
              setState(() {
                qrGeneratorProvider.setGapless(value);
                gapless = value;
              });
            }),
      ],
    );
  }
}
