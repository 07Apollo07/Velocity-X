import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/digests/keccak.dart';
import 'package:pointycastle/digests/sha256.dart';

class Crypto {
  static Uint8List Keccack512kDigest(Uint8List? dataToDigest) {
    final d = KeccakDigest(512);
    return d.process(dataToDigest!);
  }
}
