import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/qr_generator/qr_generator.dart';
import 'package:qr_scanner/pages/qr_scanner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push((context),
                        MaterialPageRoute(builder: (context) => QrGenerator()));
                  },
                  child: Text('Generate QR')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push((context),
                        MaterialPageRoute(builder: (context) => QrScanner()));
                  },
                  child: Text('Scan QR')),
            ],
          ),
        ),
      ),
    );
  }
}
