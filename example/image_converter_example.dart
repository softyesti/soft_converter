// ignore_for_file: avoid_print

import 'dart:io';

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths for the binaries are optional, if not defined
  // SoftConverter will use the system path.
  final imageConverter = SoftImageConverter();

  try {
    final files = await imageConverter.toWEBP(
      inputs: [File('assets/space.jpg')],
      output: Directory('assets/'),
    );

    for (final file in files) {
      print('Image file path: ${file.path}');
    }
  } catch (e) {
    rethrow;
  }
}
