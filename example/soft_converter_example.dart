// ignore_for_file: avoid_print

import 'dart:io';

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths for the cwebp and ffmpeg binaries are optional,
  // if not defined SoftConverter will use the system path.
  final imageConverter = SoftImageConverter();
  final videoConverter = SoftVideoConverter();

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
  } catch (e) {
    rethrow;
  }
}
