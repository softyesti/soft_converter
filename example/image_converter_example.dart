//
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths to the binaries are optional.
  //
  // If not provided, `soft_converter` will use the binaries
  // included in the bundle created during the build process.
  //
  // If your Flutter installation is not compatible with
  // `build_hooks` and `data_assets`, the system path will be used.
  final converter = SoftImageConverter();

  try {
    final files = await converter.toWEBP(
      inputs: [File('assets/space.jpg')],
      output: Directory('assets/'),
    );

    for (final file in files) {
      print('Image file path: ${file.path}');
    }
  } on Exception catch (e) {
    print(e);
  }
}
