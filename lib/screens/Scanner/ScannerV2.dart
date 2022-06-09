import 'package:flutter/material.dart';
import 'package:velocityx/screens/Scanner/app_barcode_scanner_widget.dart';

///
/// FullScreenScannerPage
class ScannerV2 extends StatefulWidget {
  @override
  _ScannerV2State createState() => _ScannerV2State();
}

class _ScannerV2State extends State<ScannerV2> {
  String _code = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text("「$_code」"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("「$_code」"),
            ],
          ),
          Expanded(
            child: AppBarcodeScannerWidget.defaultStyle(
              resultCallback: (String code) {
                setState(() {
                  _code = code;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
