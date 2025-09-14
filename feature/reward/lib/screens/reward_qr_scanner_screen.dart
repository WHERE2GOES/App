import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class RewardQrScannerScreen extends StatefulWidget {
  const RewardQrScannerScreen({super.key, required this.onScanCompleted});

  final void Function(String qrCode) onScanCompleted;

  @override
  State<RewardQrScannerScreen> createState() => _RewardQrScannerScreenState();
}

class _RewardQrScannerScreenState extends State<RewardQrScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    facing: CameraFacing.back,
  );

  String? _qrCode;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black,
      child: SafeArea(
        child: Stack(
          children: [
            MobileScanner(
              controller: _controller,
              onDetect: (capture) {
                if (_qrCode != null) return;

                final String? code = capture.barcodes.first.rawValue;

                if (code != null) {
                  setState(() {
                    _qrCode = code;
                  });

                  widget.onScanCompleted(code);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
