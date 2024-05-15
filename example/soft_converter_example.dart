// ignore_for_file: avoid_print

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  final imageConverter = SoftImageConverter();

  try {
    final file = await imageConverter.toWEBP(
      input: 'assets/space.jpg',
      output: 'assets/space.webp',
    );

    print('Image file: ${file.path}');
  } catch (e) {
    rethrow;
  }
}
