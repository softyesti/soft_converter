//
// ignore_for_file: avoid_print

import 'dart:io';

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths to the `cwebp` and `ffmpeg` binaries are optional.
  //
  // If not provided, `soft_converter` will use the binaries
  // included in the bundle created during the build process.
  //
  // If your Flutter installation is not compatible with
  // `build_hooks` and `data_assets`, the system path will be used.
  final imageConverter = SoftImageConverter();
  final videoConverter = SoftVideoConverter(
    ffmpegMacOS: 'path/to/bin',
    ffmpegLinux: 'path/to/bin',
    ffmpegWindows: 'path/to/bin',
  );

  try {
    final output = Directory('../assets/');

    final images = await imageConverter.toWEBP(
      output: output,
      inputs: [File('assets/space.jpg')],
    );

    final videos = await videoConverter.toWEBM(
      output: output,
      inputs: [File('assets/gradient.mp4')],
    );

    for (final file in images) {
      print('Image file path: ${file.path}');
    }

    for (final file in videos) {
      print('Video file path: ${file.path}');
    }
  } on Exception catch (e) {
    print(e);
  }
}
