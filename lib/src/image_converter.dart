import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:soft_converter/src/exceptions.dart';

final class SoftImageConverter {
  SoftImageConverter() {
    final dir = Directory.current.path;
    final base = p.join(dir, 'bin', 'cwebp');

    if (Platform.isWindows) {
      _exec = p.join(base, 'cwebp_windows.exe');
    } else if (Platform.isMacOS) {
      _exec = p.join(base, 'cwebp_macos');
    } else {
      _exec = p.join(base, 'cwebp_linux');
    }
  }

  late String _exec;

  /// Convert .jpg and .png images to .webp
  Future<File> toWEBP({
    required String input,
    int quality = 100,
    String? output,
  }) async {
    if (!File(input).existsSync()) {
      throw SoftConverterPathNotFound(
        'The input path not found',
        path: input,
      );
    }

    try {
      final path = p.setExtension(p.withoutExtension(output ?? input), '.webp');
      final result = await Process.run(
        _exec,
        ['-q', quality.toString(), input, '-o', path],
      );

      final file = File(path);
      if (result.exitCode != 0 && !file.existsSync()) {
        throw SoftConverterProcessException(
          'Unknown error on convert image',
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
