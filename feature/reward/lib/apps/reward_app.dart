import 'package:collection/collection.dart';
import 'package:design/util/navigation_bar_handler.dart';
import 'package:flutter/material.dart';
import 'package:reward/screens/reward_certification_screen.dart';
import 'package:reward/screens/reward_download_screen.dart';
import 'package:reward/screens/reward_qr_scanner_screen.dart';
import 'package:reward/screens/reward_road_screen.dart';
import 'package:reward/vms/reward_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class RewardApp extends StatefulWidget {
  const RewardApp({super.key, required this.vm, required this.onBack});

  final RewardViewModel vm;
  final VoidCallback onBack;

  @override
  State<RewardApp> createState() => _RewardAppState();
}

class _RewardAppState extends State<RewardApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  int? _selectedCertificateId;

  @override
  void initState() {
    super.initState();
    widget.vm.getCertificates();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (context) {
            return BackButtonListener(
              onBackButtonPressed: () async {
                _back();
                return true;
              },
              child: ListenableBuilder(
                listenable: widget.vm,
                builder: (context, child) {
                  return switch (settings.name) {
                    "/" => _buildRewardRoadScreen(),
                    "/certification" => _buildRewardCertificationScreen(
                      certificateOrder: settings.arguments as int,
                    ),
                    "/qr_scanner" => _buildRewardQrScannerScreen(),
                    "/download" => _buildRewardDownloadScreen(),
                    _ => throw Exception("Unsupported route"),
                  };
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildRewardRoadScreen() {
    final certificates = widget.vm.certificates;

    return RewardRoadScreen(
      certificates: certificates
          ?.mapIndexed(
            (index, e) => (
              isCompleted: e.isCompleted,
              onClicked: () {
                if (!e.isCompleted &&
                    (index - 1 < 0 || certificates[index - 1].isCompleted)) {
                  setState(() => _selectedCertificateId = e.id);
                  _navigatorKey.currentState?.pushNamed(
                    "/certification",
                    arguments: index + 1,
                  );
                }
              },
            ),
          )
          .toList(),
      completeButton: certificates?.lastOrNull?.isCompleted == true
          ? (
              onClicked: () {
                NavigationBarHandler.visibility.hide();
                _navigatorKey.currentState?.pushNamed("/download");
              },
            )
          : null,
    );
  }

  Widget _buildRewardCertificationScreen({required int certificateOrder}) {
    return RewardCertificationScreen(
      certificateOrder: certificateOrder,
      onBackButtonClicked: _back,
      onCameraButtonClicked: () {
        _navigatorKey.currentState?.pushNamed("/qr_scanner");
      },
    );
  }

  Widget _buildRewardQrScannerScreen() {
    return RewardQrScannerScreen(
      onScanCompleted: (qrCode) {
        _onQrScanned(qrCode: qrCode);
      },
    );
  }

  Widget _buildRewardDownloadScreen() {
    return RewardDownloadScreen(
      onDownloadButtonClicked: () async {
        final url = await widget.vm.getDownloadUrl();
        await launchUrl(Uri.parse(url.downloadLink));
      },
    );
  }

  void _back() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      _navigatorKey.currentState?.pop();
      if (_navigatorKey.currentState?.canPop() != true) {
        NavigationBarHandler.visibility.show();
      }
    } else {
      widget.onBack();
    }
  }

  void _onQrScanned({required String qrCode}) async {
    await widget.vm.authenticateCertificate(
      certificateId: _selectedCertificateId!,
      qrCode: qrCode,
    );

    _navigatorKey.currentState?.popUntil((route) => route.isFirst);
    widget.vm.getCertificates();
  }
}
