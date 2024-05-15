import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:soft_converter/soft_converter.dart';

class SoftVideoConverter {
  SoftVideoConverter() {
    final dir = Directory.current.path;
    final base = p.join(dir, 'bin', 'ffmpeg');

    if (Platform.isWindows) {
      _exec = p.join(base, 'ffmpeg_windows.exe');
    } else if (Platform.isMacOS) {
      _exec = p.join(base, 'ffmpeg_macos');
    } else {
      _exec = p.join(base, 'ffmpeg_linux');
    }
  }

  late String _exec;

  /// Convert .mp4 videos to .webm
  Future<File> toWEBM({
    required String input,
    String? output,
  }) async {
    if (!File(input).existsSync()) {
      throw SoftConverterPathNotFound(
        'The input path not found',
        path: input,
      );
    }

    try {
      final path = p.setExtension(p.withoutExtension(output ?? input), '.webm');
      final result = await Process.run(
        _exec,
        [
          '-i',
          input,
          '-f',
          'webm',
          '-c:v',
          'libvpx',
          '-b:v',
          '1M',
          '-acodec',
          'libvorbis',
          path,
          '-hide_banner',
        ],
      );

      final file = File(path);
      if (result.exitCode != 0 && !file.existsSync()) {
        throw SoftConverterProcessException(
          'Unknown error on convert video',
          code: result.exitCode,
        );
      }

      return file;
    } on ProcessException catch (e) {
      throw SoftConverterProcessException(e.message, code: e.errorCode);
    } on PathNotFoundException catch (e) {
      throw SoftConverterPathNotFound(e.message, path: e.path ?? '');
    } catch (e) {
      throw SoftConverterException(e);
    }
  }
}
