// ignore_for_file: avoid_print

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  final videoConverter = SoftVideoConverter();

  try {
    final file = await videoConverter.toWEBM(
      input: 'assets/gradient.mp4',
      output: 'assets/gradient.webm',
    );

    print('Video file: ${file.path}');
  } catch (e) {
    rethrow;
  }
}
