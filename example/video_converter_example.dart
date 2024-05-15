// ignore_for_file: avoid_print

import 'package:soft_converter/soft_converter.dart';

Future<void> main() async {
  // The paths for the binaries are optional, if not defined
  // SoftConverter will use the system path.
  final imageConverter = SoftVideoConverter(
    ffmpegWindows: 'bin/ffmpeg_win.exe',
    ffmpegMacOS: 'bin/ffmpeg_macos',
    ffmpegLinux: 'bin/ffmpeg_linux',
  );

  try {
    final file = await imageConverter.toWEBM(
      input: 'assets/gradient.mp4',
      output: 'assets/gradient.webm',
    );

    print('Video file: ${file.path}');
  } catch (e) {
    rethrow;
  }
}
