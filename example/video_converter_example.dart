// ignore_for_file: avoid_print

import 'dart:io';

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths for the binaries are optional, if not defined
  // SoftConverter will use the system path.
  final converter = SoftVideoConverter();

  try {
    final files = await converter.toWEBM(
      inputs: [File('assets/gradient.mp4')],
      output: Directory('assets/'),
    );

    for (final file in files) {
      print('Video file path: ${file.path}');
    }
  } catch (e) {
    rethrow;
  }
}
