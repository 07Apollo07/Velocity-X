import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/screens/Scanner/ScannerV2.dart';

class ScannerInter extends StatelessWidget {
  const ScannerInter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.to(() => ScannerV2());
                },
                child: Text("Archive Location Code")),
            ElevatedButton(
                onPressed: () {
                  Get.to(() => ScannerV2());
                },
                child: Text("Archive Document Code")),
          ],
        ),
      ),
    );
  }
}
