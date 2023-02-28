import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QrScannerResult extends StatefulWidget {
  final String qrCode;
  const QrScannerResult({super.key, required this.qrCode});

  @override
  State<QrScannerResult> createState() => _QrScannerResultState();
}

class _QrScannerResultState extends State<QrScannerResult> {
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner Result'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    Clipboard.setData(ClipboardData(text: widget.qrCode));
                    FToast().showToast(
                      toastDuration: const Duration(seconds: 2),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.greenAccent,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.check),
                            SizedBox(
                              width: 12.0,
                            ),
                            Text('Text Copied'),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Text(widget.qrCode)),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Copy to Clipboard'),
                  IconButton(
                      onPressed: () async {
                        Clipboard.setData(ClipboardData(text: widget.qrCode));
                        FToast().showToast(
                          toastDuration: const Duration(seconds: 2),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24.0, vertical: 12.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.greenAccent,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.check),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Text('Text Copied'),
                              ],
                            ),
                          ),
                        );
                      },
                      icon: Row(
                        children: [
                          const Icon(Icons.copy),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
