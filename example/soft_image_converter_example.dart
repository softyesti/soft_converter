// ignore_for_file: avoid_print

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths for the binaries are optional, if not defined
  // SoftConverter will use the system path.
  final imageConverter = SoftImageConverter(
    cwebpWindows: 'bin/cwebp_win.exe',
    cwebpMacOS: 'bin/cwebp_macos',
    cwebpLinux: 'bin/cwebp_linux',
  );

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
