import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/digests/keccak.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/export.dart';

class Crypto {
  static Uint8List Keccack512kDigest(Uint8List? dataToDigest) {
    final d = KeccakDigest(512);
    return d.process(dataToDigest!);
  }

  Uint8List Keccack256kDigest(Uint8List? dataToDigest) {
    final d = KeccakDigest(256);
    return d.process(dataToDigest!);
  }

  Uint8List sha256Digest(Uint8List dataToDigest) {
    final d = SHA256Digest();
    return d.process(dataToDigest);
  }

  Uint8List ripemd128Digest(Uint8List dataToDigest) {
    final d = RIPEMD128Digest();
    return d.process(dataToDigest);
  }

  Uint8List aesCbcEncrypt(
      Uint8List key, Uint8List iv, Uint8List paddedPlaintext) {
    print(paddedPlaintext.lengthInBytes);
    assert([128, 192, 256].contains(key.length * 8));
    assert(128 == iv.length * 8);
    assert(0 == paddedPlaintext.length % 128);

    // Create a CBC block cipher with AES, and initialize with key and IV

    final cbc = CBCBlockCipher(AESEngine())
      ..init(true, ParametersWithIV(KeyParameter(key), iv)); // true=encrypt

    // Encrypt the plaintext block-by-block

    final cipherText = Uint8List(paddedPlaintext.length); // allocate space

    var offset = 0;
    while (offset < paddedPlaintext.length) {
      offset += cbc.processBlock(paddedPlaintext, offset, cipherText, offset);
    }
    assert(offset == paddedPlaintext.length);

    return cipherText;
  }

  Uint8List aesCbcDecrypt(Uint8List key, Uint8List iv, Uint8List cipherText) {
    assert([128, 192, 256].contains(key.length * 8));
    assert(128 == iv.length * 8);
    assert(128 == cipherText.length * 8);

    // Create a CBC block cipher with AES, and initialize with key and IV

    final cbc = CBCBlockCipher(AESEngine())
      ..init(false, ParametersWithIV(KeyParameter(key), iv)); // false=decrypt

    // Decrypt the cipherText block-by-block

    final paddedPlainText = Uint8List(cipherText.length); // allocate space

    var offset = 0;
    while (offset < cipherText.length) {
      offset += cbc.processBlock(cipherText, offset, paddedPlainText, offset);
    }
    assert(offset == cipherText.length);

    return paddedPlainText;
  }

  Uint8List pad(Uint8List bytes, int blockSizeBytes) {
    final padLength = blockSizeBytes - (bytes.length % blockSizeBytes);

    final padded = Uint8List(bytes.length + padLength)..setAll(0, bytes);
    PKCS7Padding().addPadding(padded, bytes.length);

    return padded;
  }

  Uint8List unpad(Uint8List padded) {
    return padded.sublist(0, padded.length - PKCS7Padding().padCount(padded));
  }

}
